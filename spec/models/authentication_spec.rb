require 'rails_helper'

RSpec.describe Authentication, type: :model do
	describe "associations" do
		describe "belongs to user" do
			it { should belong_to(:user) }
		end
	end
end
