require 'rails_helper'

module Core
  RSpec.describe Account, type: :model do
		before do
			@account = FactoryGirl.build(:account)
		end

 		subject { @account }

		it "has a valid factory" do
			expect(@account).to be_valid
		end

 		# accessible attributes
 		it { should respond_to(:name) }
		it { should respond_to(:owner) }

		describe '(Validations)' do
			it "is invalid without a name" do
				@account.name = nil
				expect(@account).not_to be_valid
			end

			it "is invalid when name is too long" do
				@account.name = 'a'*101
				expect(@account).not_to be_valid
			end
			
			it "is invalid without a subdomain" do
				@account.subdomain = nil
				expect(@account).not_to be_valid
			end

			it "is invalid when subdomain is too long" do
				@account.subdomain = 'a'*51
				expect(@account).not_to be_valid
			end
			
			it "is invalid when subdomain is not unique" do
				acnt = FactoryGirl.create(:account)
				@account.subdomain = acnt.subdomain
				expect(@account).not_to be_valid
			end
			
			it "is invalid when subdomain is a restricted word" do
				restricted_words = %w[admin support info test ADMIN SuPPort iNFo]
				restricted_words.each do |restricted_word|
					@account.subdomain = restricted_word
					expect(@account).not_to be_valid
				end
			end
		end
		
		it "subdomain is saved as lowercase" do
			@account.subdomain = 'UPPER'
			@account.save
			expect(@account.subdomain).to eq 'upper'
		end

		describe "(Associations)" do
			it "Owner can be blank" do
				@account.owner = nil
				expect(@account.owner).to be_nil
			end
			
			it "belongs to 1 Owner" do
				user = @account.build_owner
				expect(@account.owner).to eq user
			end
		end

  end
end
