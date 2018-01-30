require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe "validations" do
  	describe "validation of presence of title" do
  		it { should validate_presence_of(:title) }
  	end

  	describe "validation of presence of description" do
  		it { should validate_presence_of(:description) }
  	end

  	describe "validation of presence of image" do
  		it { should validate_presence_of(:image) }
  	end

  	describe "validation of presence of ingredients" do
  		it { should validate_presence_of(:ingredients) }
  	end

  	describe "validation of presence of directions" do
  		it { should validate_presence_of(:directions) }
  	end
  end

  describe "associations" do 
  	describe "has many ingredients" do 
  		it { should have_many(:ingredients).inverse_of(:recipe).dependent(:destroy) }
  	end

  	describe "has many directions" do 
  		it { should have_many(:directions).inverse_of(:recipe).dependent(:destroy) }
  	end

  	describe "belongs to user" do 
  		it { should belong_to(:user) }
  	end
  end

  describe "acceptance of nested attributes" do 
  	describe "accepts nested attribute of directions" do
  		it { should accept_nested_attributes_for(:directions).allow_destroy(true) }
  	end

  	describe "accepts nested attribute of ingredients" do
  		it { should accept_nested_attributes_for(:ingredients).allow_destroy(true)}
  	end
  end

  describe "recipe custom methods test" do

    it "will pass if it returns the correct number of ingredients" do
      @recipe = Recipe.create(title: "some_title", description: "some_description", image: "some_image.png")
      Ingredient.create(name: "something", recipe_id: @recipe.id)
      Direction.create(step: "something", recipe_id: @recipe.id)
      expect(@recipe.ing_count).to eq(1)
    end

  end

end
