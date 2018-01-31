require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do 
  	describe "validation of presence of name" do
  		it { should validate_presence_of(:name) }
  	end

  	describe "validation of presence of email" do
  		it { should validate_presence_of(:email) }
  	end

  	describe "validation of presence of password" do
  		it { should validate_presence_of(:password) }
  	end

  	describe "validation of password confirmation" do
  		it { should validate_confirmation_of(:password) }
  	end

  	describe "validation of length of name" do
  		it { should validate_length_of(:name).is_at_least(3) }
  	end

  	describe "validation of uniqueness of name" do
  		it { should validate_uniqueness_of(:name) }
  	end

	describe "validation of uniqueness of email" do
  		it { should validate_uniqueness_of(:email) }
  	end  	

  	describe "validation of format of email" do
  		it "will pass if email entered is valid" do 
  			should allow_values('ryan@hotmail.com', 'johndoe@gmail.com').for(:email)
  		end

  		it "will failed if email entered is invalid" do 
  			should_not allow_values('ryan@hotmail', 'abc.com').for(:email)
  		end
  	end  	
  end	

  describe "check if user has secure password" do 
  	it { should have_secure_password }
  end	

  describe "associations" do 
  	describe "has many authentications" do 
  		it { should have_many(:authentications).dependent(:destroy) }
  	end

  	describe "has many recipes" do 
  		it { should have_many(:recipes).dependent(:destroy) }
  	end
  end

end
