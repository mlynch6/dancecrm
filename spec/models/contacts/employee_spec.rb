require 'rails_helper'

module Contacts
  RSpec.describe Employee, type: :model do
		before do
			@employee = FactoryGirl.build(:employee)
		end

 		subject { @employee }

		it "has a valid factory" do
			expect(@employee).to be_valid
		end

		it ".contact_type returns 'Employee'" do
			expect(@employee.contact_type).to eq 'Employee'
		end
	end
end
