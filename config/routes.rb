Rails.application.routes.draw do
	mount Core::Engine => "/", as: 'core'	
	mount Contacts::Engine => "/contacts", as: 'contacts'	
end
