FactoryGirl.define do
	factory :account, :class => Core::Account do |account|
		name 			{ Faker::Company.name.first(100) }
		subdomain { Faker::Internet.domain_word.first(50) }
		
		after(:build) do |account|
			# owner association
			account.owner = FactoryGirl.create(:user, account: account) unless account.owner
		end
	end
end