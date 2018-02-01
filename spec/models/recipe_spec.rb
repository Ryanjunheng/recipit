require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe "validations" do
  	describe "validation of presence of title" do
  		it { should validate_presence_of(:title) }
  	end

  	describe "validation of presence of description" do
  		it { should validate_presence_of(:description) }
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

  describe "recipe model custom methods test" do

    it "will pass if it returns the correct number of ingredients" do
      @user = User.create(name:"somebody", email:"somebody@mail.com", password: "password")
      @recipe = Recipe.create(title: "something", description: "something", user_id: @user.id, ingredients_attributes: [{name:"carrot"}, {name:"lettuce"}, {name:"chicken"}, {name:"salt"}], directions_attributes: [{step: "step1"}, {step: "step2"}, {step: "step3"}, {step: "step4"}, {step: "step5"}])
      expect(@recipe.ing_count).to eq(4)
    end

    it "will pass if it returns the correct number of steps" do
      @user = User.create(name:"somebody", email:"somebody@mail.com", password: "password")
      @recipe = Recipe.create(title: "something", description: "something", user_id: @user.id, ingredients_attributes: [{name:"carrot"}, {name:"lettuce"}, {name:"chicken"}, {name:"salt"}], directions_attributes: [{step: "step1"}, {step: "step2"}, {step: "step3"}, {step: "step4"}, {step: "step5"}])
      expect(@recipe.dir_count).to eq(5)
    end

  end

end
