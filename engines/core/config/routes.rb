Core::Engine.routes.draw do
	# constraints(Core::Constraints::SubdomainRequired) do
	# 	scope module: 'account' do
	# 		root to: 'dashboard#index', as: :account_root
	# 		get  '/sign_in', to: 'sessions#new', 	as: :sign_in
	# 		post '/sign_in', to: 'sessions#create', 	as: :sessions
	# 	end
	# end
	
	root "home#index"
	
	get "/sign_up", to: "accounts#new", as: :sign_up
	post "/sign_up", to: "accounts#create", as: :do_sign_up
	
end
