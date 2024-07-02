class Word < ApplicationRecord
  belongs_to :sentence
  has_one_attached :audio

  validates :content, presence: true
  validates :translation, presence: true
end
