class User < ApplicationRecord
  has_many :reviews
  has_many :words, through: :reviews
  has_one :user_streak

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

  def name
    # TODO
    "User ##{id}"
  end

  def situations_learned_count
    # TODO
    1
  end

  def vocabulary_learned_count
    # TODO
    2
  end

  # def reviews_count
  #   reviews.where("next_review_date <= ?", Time.current).count
  # end

  def current_streak
    Current.user.user_streak.current_streak
  end

  def highest_streak
    Current.user.user_streak.max_streak
  end

  def recent_activities
    # TODO
    [
      {
        type: "learned_situation",
        description: "Learned Introductions situation",
        created_at: 1.day.ago
      },
      {
        type: "learned_situation",
        description: "Learned Daily essentials situation",
        created_at: 2.days.ago
      }
    ].map { |a| OpenStruct.new(a) }
  end
end

# <% Current.user.recent_activities.each do |activity| %>
#   <li class="flex items-center">
#     <span class="text-2xl mr-4"><%= activity_icon(activity.type) %></span>
#     <div>
#       <p class="text-gray-800 font-medium"><%= activity.description %></p>
#       <p class="text-sm text-gray-500"><%= time_ago_in_words(activity.created_at) %> ago</p>
#     </div>
#   </li>
# <% end %>
