require 'rails_helper'

RSpec.describe Ingredient, type: :model do
	describe "validation" do
		describe "validation of presence of parent recipe" do
			it { should validate_presence_of(:recipe) }
		end
	end

	describe "associations" do
		describe "belongs to recipe" do
			it { should belong_to(:recipe) }
		end
	end
end
