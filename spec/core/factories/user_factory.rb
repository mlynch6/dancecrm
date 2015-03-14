FactoryGirl.define do
	factory :user, :class => Core::User do |user|
		email 									{ Faker::Internet.free_email.first(50) }
		password								'password'
		password_confirmation		'password'
		
		after(:build) do |user|
			# account association
			user.account = FactoryGirl.create(:account) unless user.account
		end
	end
end