module Core
  class ApplicationController < ActionController::Base
		layout 'application'
		
		def current_account
			if user_signed_in?
				@current_account ||= begin
					account_id = env['warden'].user(:scope => :account)
					Core::Account.find(account_id)
				end
			end
		end
		helper_method :current_account
		
		def current_user
			if user_signed_in?
				@current_user ||= begin
					user_id = env['warden'].user(:scope => :user)
					Core::User.find(user_id)
				end
			end
		end
		helper_method :current_user
		
		def user_signed_in?
			env['warden'].authenticated?(:user)
		end
		helper_method :user_signed_in?
		
  end
end
