class Context < ApplicationRecord
  has_many :situations, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
