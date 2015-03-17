require "core/constraints/subdomain_required"

Core::Engine.routes.draw do
	constraints(Core::Constraints::SubdomainRequired) do
		scope module: 'my_account' do
			root to: 'dashboard#index', as: :dashboard
			get  '/sign_in', to: 'sessions#new'
			post '/sign_in', to: 'sessions#create', 	as: :sessions
			get '/signout', to: 'sessions#destroy'
		end
	end
	
	root "home#index"
	
	get "/sign_up", to: "accounts#new", as: :sign_up
	post "/sign_up", to: "accounts#create", as: :do_sign_up
	
end
