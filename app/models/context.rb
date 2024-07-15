class Context < ApplicationRecord
  has_many :situations, dependent: :destroy
  has_many :reviews
  has_many :words, through: :reviews

  validates :name, presence: true, uniqueness: true

  def reviews_due_count
    reviews.where("next_review_date <= ?", Time.current.end_of_day).count
  end
end
