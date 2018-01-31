class Direction < ApplicationRecord
  belongs_to :recipe, optional: true
  validates :recipe, presence: true
end
