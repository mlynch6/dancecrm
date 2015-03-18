Rails.application.config.middleware.use Warden::Manager do |manager|
	manager.default_strategies :password
end
				
Warden::Manager.serialize_into_session do |user|
	user.id
end
		
Warden::Manager.serialize_from_session do |id|
	Core::User.find(id)
end

Warden::Strategies.add(:password) do
	def subdomain
		ActionDispatch::Http::URL.extract_subdomains(request.host, 1)
	end
	
	def valid?		
		subdomain.present? && params['user']
	end
	
	def authenticate!
		return fail! unless user = Core::User.joins(:account).find_by(email: params['user']['email'], accounts: { subdomain: subdomain })
		return fail! unless user.authenticate(params['user']['password'])
		success! user
	end
end