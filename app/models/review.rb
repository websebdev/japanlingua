class Review < ApplicationRecord
  belongs_to :user
  belongs_to :word
  belongs_to :context

  validates :next_review_date, presence: true
  validates :ease_factor, presence: true, numericality: { greater_than: 0 }
  validates :interval, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
