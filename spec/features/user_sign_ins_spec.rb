require 'rails_helper'

RSpec.feature "UserSignIns", type: :feature do
	describe "User sign in process", :type => :feature do
 		before :each do
   			User.create(name: 'user', email: 'user@example.com', password: 'password')
 		end

		it "signs me in" do
			visit '/sign_in'
			within("#sign-in") do
				fill_in 'email', with: 'user@example.com'
				fill_in 'password', with: 'password'
			end
		   click_button 'Submit'
		   expect(page).to have_content 'Signed in as'
	 	end
  	end
end
