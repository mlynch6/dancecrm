module Contacts
  class ApplicationController < Core::ApplicationController
		layout 'application'
		before_filter :authenticate_user!
  end
end
