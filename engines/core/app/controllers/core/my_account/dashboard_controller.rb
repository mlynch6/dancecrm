require_dependency "core/application_controller"

module Core
  class MyAccount::DashboardController < Core::ApplicationController
		before_filter :authenticate_user!
		
    def index
    end
  end
end
