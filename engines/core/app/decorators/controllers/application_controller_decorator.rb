::ApplicationController.class_eval do
	def current_account
		if user_signed_in?
			@current_account ||= current_user.account
		end
	end
	helper_method :current_account

	def current_user
		if user_signed_in?
			@current_user ||= env['warden'].user(scope: :user)
		end
	end
	helper_method :current_user
	
	def user_signed_in?
		env['warden'].authenticated?(:user)
	end
	helper_method :user_signed_in?
	
	def authenticate_user!
		unless user_signed_in?
			flash[:notice] = 'Please sign in.'
			redirect_to sign_in_path
		end
	end
	
	def force_authentication!(user)
		env['warden'].set_user(user, scope: :user)
	end
end