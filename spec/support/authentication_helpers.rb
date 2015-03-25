module AuthenticationHelpers
	include Warden::Test::Helpers
	
	def self.included(base)
		base.after do
			logout
		end
	end
	
	def sign_in_as(user)
		login_as(user, scope: :user)
	end
	
end