require_dependency "core/application_controller"

module Core
  class MyAccount::SessionsController < Core::ApplicationController
    def new
			@user = User.new
    end
		
		def create
			if warden.authenticate(:scope => :user)
				flash[:success] = "Welcome #{params['user']['email']}"
				redirect_to dashboard_path
			else
				@user = User.new
				flash[:error] = "Invalid email or password"
				render :new
			end
		end
		
		def destroy
			warden.logout
			flash[:success] = "Logged out!"
			redirect_to sign_in_url
		end
  end
end
