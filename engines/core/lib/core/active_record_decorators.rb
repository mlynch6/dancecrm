ActiveRecord::Base.class_eval do
	def self.scoped_to_account
		belongs_to :account, class_name: 'Core::Account'
		
		association_name = self.to_s.split('::').join('_').downcase.pluralize
		Core::Account.has_many association_name.to_sym, class_name: self.to_s, dependent: :destroy
	end
end