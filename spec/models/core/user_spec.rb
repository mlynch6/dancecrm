require 'rails_helper'

module Core
  RSpec.describe User, type: :model do
		before do
			@user = FactoryGirl.build(:user)
		end

 		subject { @user }

		it "has a valid factory" do
			expect(@user).to be_valid
		end

 		# accessible attributes
 		it { should respond_to(:email) }
		it { should respond_to(:password) }
		it { should respond_to(:password_confirmation) }
		it { should respond_to(:account) }

		describe '(Validations)' do			
			it "is invalid without an email" do
				@user.email = nil
				expect(@user).not_to be_valid
			end

			it "is invalid when email is too long" do
				@user.email = 'a'*51
				expect(@user).not_to be_valid
			end
			
	  	it "is invalid when email is invalid" do
	  		emails = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
	  		emails.each do |invalid_email|
	  			@user.email = invalid_email
	  			expect(@user).not_to be_valid
	  		end
	  	end
			
			it "is invalid without a password" do
				@user.password = nil
				expect(@user).not_to be_valid
			end
			
			it "is invalid when password doesn't match password confirmation" do
				@user.password = 'password'
				@user.password_confirmation = 'different'
				expect(@user).not_to be_valid
			end
			
			it "is valid when password matches password confirmation" do
				@user.password = 'same_password'
				@user.password_confirmation = 'same_password'
				expect(@user).to be_valid
			end
		end

		describe "(Associations)" do
			it "has 1 Account" do
				account = FactoryGirl.create(:account)
				user = FactoryGirl.create(:user, account: account)
				expect(user.reload.account).to eq account
			end
		end
  end
end
