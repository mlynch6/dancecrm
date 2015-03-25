module Contacts
  class Person < ActiveRecord::Base
		GENDERS = ['Female', 'Male']
		
		scoped_to_account
		extend Core::ScopedTo
		
		validates :account_id, presence: true
		validates :first_name, presence: true, length: { maximum: 30 }
		validates :middle_name, length: { maximum: 30 }
		validates :last_name, presence: true, length: { maximum: 30 }
		validates :suffix, length: { maximum: 10 }
		validates :gender, allow_blank: true, inclusion: { in: GENDERS }
		validates :birth_date, allow_blank: true, timeliness: { type: :date, before: :today, before_message: 'must be in the past' }
		validates :email, allow_blank: true, length: { maximum: 50 }, email: true
		validates :active, inclusion: { in: [true, false] }
		
		scope :employees, -> { where(type: 'Contacts::Employee') }
		scope :students, -> { where(type: 'Contacts::Student') }
		
		def name
			middle_name.present? ? "#{last_name}, #{first_name} #{middle_name}" : "#{last_name}, #{first_name}"
		end
		
		def full_name
			middle_name.present? ? "#{first_name} #{middle_name} #{last_name}" : "#{first_name} #{last_name}"
		end
		
		def contact_type
			'Contact'
		end
		
		def birth_date_mdY
			birth_date.try(:strftime, '%-m/%-d/%Y')
		end
		def birth_date_mdY=(date)
			self.birth_date = date.present? ? Date.strptime(date, '%m/%d/%Y') : nil
		end
  end
end
