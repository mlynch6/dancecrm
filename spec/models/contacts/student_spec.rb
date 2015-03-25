require 'rails_helper'

module Contacts
  RSpec.describe Student, type: :model do
		before do
			@student = FactoryGirl.build(:student)
		end

 		subject { @student }

		it "has a valid factory" do
			expect(@student).to be_valid
		end

		it ".contact_type returns 'Student'" do
			expect(@student.contact_type).to eq 'Student'
		end
	end
end
