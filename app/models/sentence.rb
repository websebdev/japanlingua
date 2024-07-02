class Sentence < ApplicationRecord
  belongs_to :situation
  has_many :words, dependent: :destroy
  has_one_attached :audio

  validates :content, presence: true
  validates :translation, presence: true

  accepts_nested_attributes_for :words, allow_destroy: true
end
