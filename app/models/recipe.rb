class Recipe < ApplicationRecord
	belongs_to :user
	has_many :ingredients, inverse_of: :recipe, dependent: :destroy  
	has_many :directions, inverse_of: :recipe, dependent: :destroy 
	accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :directions, reject_if: :all_blank, allow_destroy: true
	mount_uploader :image, ImageUploader
	validates :title, :description, :image, presence: true
end
