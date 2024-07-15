class Word < ApplicationRecord
  belongs_to :sentence
  has_many :reviews
  has_many :users, through: :reviews
  has_one_attached :audio

  validates :content, presence: true
  validates :translation, presence: true
  validates :reading_hiragana, presence: true
  validates :reading_romaji, presence: true
end
