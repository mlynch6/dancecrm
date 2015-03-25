require 'core/constraints/subdomain_required'

Contacts::Engine.routes.draw do
	constraints(Core::Constraints::SubdomainRequired) do
		resources :contacts, except: [:show]
	end
end