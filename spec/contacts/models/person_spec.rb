require 'rails_helper'

module Contacts
  RSpec.describe Person, type: :model do
		before do
			@person = FactoryGirl.build(:person)
		end

 		subject { @person }

		it "has a valid factory" do
			expect(@person).to be_valid
		end

 		# accessible attributes
 		it { should respond_to(:first_name) }
		it { should respond_to(:middle_name) }
		it { should respond_to(:last_name) }
		it { should respond_to(:suffix) }
		it { should respond_to(:gender) }
		it { should respond_to(:birth_date) }
		it { should respond_to(:email) }
		it { should respond_to(:active) }
		it { should respond_to(:type) }
		it { should respond_to(:account) }
		it { should respond_to(:name) }
		it { should respond_to(:full_name) }
		

  	it "is created as active" do
			expect(@person.active).to be true
  	end
		
		describe '(Validations)' do
			it "is invalid without an account" do
				@person.account_id = nil
				expect(@person).not_to be_valid
			end
			
			it "is invalid without a first_name" do
				@person.first_name = nil
				expect(@person).not_to be_valid
			end

			it "is invalid when first_name is too long" do
				@person.first_name = 'a'*31
				expect(@person).not_to be_valid
			end
			
			it "is invalid when middle_name is too long" do
				@person.middle_name = 'a'*31
				expect(@person).not_to be_valid
			end
			
			it "is invalid without a last_name" do
				@person.last_name = nil
				expect(@person).not_to be_valid
			end

			it "is invalid when last_name is too long" do
				@person.last_name = 'a'*31
				expect(@person).not_to be_valid
			end
			
			it "is invalid when suffix is too long" do
				@person.suffix = 'a'*11
				expect(@person).not_to be_valid
			end
			
	  	it "is invalid when gender is not 'Male' or 'Female'" do
	  		genders = %w[abc unknown 2]
	  		genders.each do |invalid_gender|
	  			@person.gender = invalid_gender
	  			expect(@person).not_to be_valid
	  		end
	  	end
			
	  	it "does not accept birth_date when it is an invalid date" do
	  		dts = ["abc", "2/31/2012"]
	  		dts.each do |invalid_date|
	  			@person.birth_date = '13/13/2013'
	  			expect(@person.birth_date).to be_nil
				end
			end
			
			it "is invalid when birth_date is today" do
	  		@person.birth_date = Date.today
	  		expect(@person).not_to be_valid
			end
			
			it "is invalid when birth_date is after today" do
	  		@person.birth_date = Date.today + 1.day
	  		expect(@person).not_to be_valid
			end
			
	  	it "is invalid when email is invalid" do
	  		emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
	  		emails.each do |invalid_email|
	  			@person.email = invalid_email
	  			expect(@person).not_to be_valid
	  		end
	  	end
			
			it "is invalid when email is too long" do
				@person.email = 'a'*51
				expect(@person).not_to be_valid
			end
		end

		describe "(Associations)" do
			it "has 1 Account" do
				account = FactoryGirl.create(:account)
				person = FactoryGirl.create(:person, account: account)
				expect(person.reload.account).to eq account
			end
		end
		
		describe ".name" do
			it "returns 'last, first' when there is no middle name" do
				@person.first_name = 'John'
				@person.last_name = 'Doe'
				expect(@person.name).to eq 'Doe, John'
			end
			
			it "returns 'last, first middle' when there is a middle name" do
				@person.first_name = 'John'
				@person.middle_name = 'Edward'
				@person.last_name = 'Doe'
				expect(@person.name).to eq 'Doe, John Edward'
			end
		end
		
		describe ".full_name" do
			it "returns 'first last' when there is no middle name" do
				@person.first_name = 'John'
				@person.last_name = 'Doe'
				expect(@person.full_name).to eq 'John Doe'
			end
			
			it "returns 'first middle last' when there is a middle name" do
				@person.first_name = 'John'
				@person.middle_name = 'Edward'
				@person.last_name = 'Doe'
				expect(@person.full_name).to eq 'John Edward Doe'
			end
		end
		
		describe "(Scopes)" do
			it "employees scope only shows Employees" do
				employee = FactoryGirl.create(:employee)
				person = FactoryGirl.create(:person)
				records = Contacts::Person.employees
				
				expect(records.count).to eq 1
				expect(records).to include(employee)
				expect(records).not_to include(person)
			end
			
			it "students scope only shows Students" do
				student = FactoryGirl.create(:student)
				person = FactoryGirl.create(:person)
				records = Contacts::Person.students
				
				expect(records.count).to eq 1
				expect(records).to include(student)
				expect(records).not_to include(person)
			end
		end
  end
end
