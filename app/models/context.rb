class Context < ApplicationRecord
  has_many :situations, dependent: :destroy
  has_many :reviews

  validates :name, presence: true, uniqueness: true
end
