require 'validates_timeliness'
require 'simple_form'
require 'will_paginate'

module Contacts
  class Engine < ::Rails::Engine
    isolate_namespace Contacts
		
		initializer :append_migrations do |app|
			unless app.root.to_s.match(root.to_s)
				config.paths["db/migrate"].expanded.each do |p|
					app.config.paths["db/migrate"] << p
				end
			end
		end
  end
end
