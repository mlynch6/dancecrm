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
		
		config.to_prepare do
			decorators_path = Core::Engine.root + "app/decorators/**/*.rb"
			Dir.glob(decorators_path) do |file|
				Rails.configuration.cache_classes ? require(file) : load(file)
			end
		end
		
  end
end
