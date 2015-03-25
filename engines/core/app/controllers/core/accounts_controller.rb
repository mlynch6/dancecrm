require_dependency "core/application_controller"

module Core
  class AccountsController < ApplicationController
		def new
			@account = Core::Account.new
			@account.build_owner
		end
		
		def create
			@account = Core::Account.new(account_params)
			@account.owner.account = @account
			if @account.save
				force_authentication!(@account.owner)
				flash[:success] = 'Your account was successfully created.'
				redirect_to core.dashboard_url(subdomain: @account.subdomain)
			else
				render :new
			end
		end
		
		private
		
		def account_params
			params.require(:account).permit(:name, :subdomain,
						{ owner_attributes: [:email, :password, :password_confirmation] }
						)
		end
  end
end
