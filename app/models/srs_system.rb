class SrsSystem
  def initialize(user)
    @user = user
  end

  def process_review(review, known)
    if known
      review.interval = calculate_next_interval(review)
      review.ease_factor = [ review.ease_factor + 0.1, 2.5 ].min
    else
      review.interval = 0
      review.ease_factor = [ review.ease_factor - 0.2, 1.3 ].max
    end

    review.next_review_date = Time.current + review.interval.days
    review.save!

    update_user_streak
  end

  def add_new_words(situation)
    situation.words.each do |word|
      unless @user.reviews.exists?(word: word)
        @user.reviews.create!(
          word: word,
          context: situation.context,
          next_review_date: Time.current,
          ease_factor: 2.5,
          interval: 0
        )
      end
    end

    update_user_streak
  end

  private

  def calculate_next_interval(review)
    case review.interval
    when 0 then 1
    when 1 then 6
    else
      (review.interval * review.ease_factor).round
    end
  end

  def update_user_streak
    streak = @user.user_streak || @user.create_user_streak

    if streak.last_activity_date == Date.current
      # Already updated today, do nothing
    elsif streak.last_activity_date == Date.yesterday
      streak.current_streak += 1
      streak.max_streak = [ streak.current_streak, streak.max_streak ].max
    else
      streak.current_streak = 1
    end

    streak.last_activity_date = Date.current
    streak.save!
  end
end
