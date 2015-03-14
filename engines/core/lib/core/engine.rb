require 'bcrypt'
require 'warden'
require 'simple_form'

module Core
  class Engine < ::Rails::Engine
    isolate_namespace Core
		
		initializer :append_migrations do |app|
			unless app.root.to_s.match(root.to_s)
				config.paths["db/migrate"].expanded.each do |p|
					app.config.paths["db/migrate"] << p
				end
			end
		end
		
		initializer "subscribem.middleware.warden" do
			Rails.application.config.middleware.use Warden::Manager do |manager|
				manager.serialize_into_session do |user|
					user
				end
				manager.serialize_from_session do |id|
					id
				end
			end
		end
		
  end
end
