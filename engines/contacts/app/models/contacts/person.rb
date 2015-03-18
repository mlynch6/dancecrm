module Contacts
  class Person < ActiveRecord::Base
		GENDERS = ['Female', 'Male']
		
		belongs_to :account, class_name: 'Core::Account'
		
		validates :account_id, presence: true
		validates :first_name, presence: true, length: { maximum: 30 }
		validates :middle_name, length: { maximum: 30 }
		validates :last_name, presence: true, length: { maximum: 30 }
		validates :suffix, length: { maximum: 10 }
		validates :gender, allow_blank: true, inclusion: { in: GENDERS }
		validates :birth_date, allow_blank: true, timeliness: { type: :date, before: :today }
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
  end
end
