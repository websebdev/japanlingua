class Situation < ApplicationRecord
  belongs_to :context
  has_many :sentences, dependent: :destroy
  has_many :words, through: :sentences

  validates :title, presence: true

  accepts_nested_attributes_for :sentences, allow_destroy: true
end
