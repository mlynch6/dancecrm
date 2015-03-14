module Core
  class Account < ActiveRecord::Base
		self.table_name = 'accounts'
		
		EXCLUDED_SUBDOMAINS = %w[admin support info test]
		
		belongs_to :owner, class_name: 'Core::User'
		accepts_nested_attributes_for :owner
		has_many :users, class_name: 'Core::User', dependent: :destroy
		
		before_validation { self.subdomain = subdomain.to_s.downcase }
		
		validates :name, presence: true, length: { maximum: 100 }
		validates :subdomain, presence: true, length: { maximum: 50 }, uniqueness: true
		validates_exclusion_of :subdomain, in: EXCLUDED_SUBDOMAINS, 
							message: 'is not allowed. Please choose another subdomain'
		validates_format_of :subdomain, with: /\A[\w\-]+\Z/i, 
							message: 'is not allowed. Please choose another subdomain'
  end
end
