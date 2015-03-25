Rails.application.routes.draw do
	mount Core::Engine => "/", as: 'core'	
	mount Contacts::Engine => "/", as: 'contacts'	
end
