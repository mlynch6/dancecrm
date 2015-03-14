module Core
  class User < ActiveRecord::Base
		self.table_name = 'users'
		
		has_secure_password
		
		belongs_to :account, class_name: 'Core::Account'
		
		validates :email, presence: true, length: { maximum: 50 }, email: true
  end
end
