class UserStreak < ApplicationRecord
  belongs_to :user

  validates :current_streak, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :max_streak, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :last_activity_date, presence: true
end
