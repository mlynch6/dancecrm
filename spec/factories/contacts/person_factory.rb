FactoryGirl.define do
	factory :person, :class => Contacts::Person do |person|
		first_name 								{ Faker::Name.first_name.first(30) }
		last_name 								{ Faker::Name.last_name.first(30) }
		
		after(:build) do |person|
			# account association
			person.account = FactoryGirl.create(:account) unless person.account
		end
		
		trait :inactive do
			active				false
		end
		
		trait :complete do
			middle_name 						{ Faker::Name.first_name.first(30) }
			suffix 									{ Faker::Name.suffix.first(10) }
			gender									{ Contacts::Person.genders.shuffle.first }
			birth_date							{ Faker::Date.birthday }
			email										{ Faker::Internet.free_email("#{first_name} #{last_name}") }
		end
	end
end