require 'rails_helper'

feature "User Sign Out" do
	extend SubdomainHelpers
	
	let!(:account) { FactoryGirl.create(:account) }
	let(:sign_in_url) { "http://#{account.subdomain}.example.com/sign_in" }
	let(:root_url) { "http://#{account.subdomain}.example.com/" }
	
	within_account_subdomain do
		before do
			visit sign_in_url
			fill_in "Email", with: account.owner.email
			fill_in "Password", with: account.owner.password
			click_button "Sign in"
			expect(page).to have_success_message "Welcome #{account.owner.email}"
		end
		
		scenario "a signed in user can successfully sign out" do
			click_link 'Sign Out'
			
			expect(page).to have_success_message "Logged out!"
			
			# check redirects back to root
			expect(page.current_url).to eq sign_in_url
		end
		
		scenario "user cannot access application pages anymore after signing out" do
			click_link 'Sign Out'
		
			# Try to access Dashboard
			visit "http://#{account.subdomain}.example.com/"
			
			# check that redirects to sign in page
			expect(page.current_url).to eq sign_in_url
			expect(page).to have_info_message 'Please sign in'
		end
	end

end