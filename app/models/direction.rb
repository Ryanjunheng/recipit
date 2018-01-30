class Direction < ApplicationRecord
  belongs_to :recipe
  validates :recipe, presence: true
end
