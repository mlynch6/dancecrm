require 'rails_helper'

feature "User Sign In" do
	extend SubdomainHelpers
	
	let!(:account) { FactoryGirl.create(:account) }
	let(:sign_in_url) { "http://#{account.subdomain}.example.com/sign_in" }
	let(:root_url) { "http://#{account.subdomain}.example.com/" }
	
	within_account_subdomain do
		scenario "has correct title & navigation highlighted" do
			visit sign_in_url
		
			expect(page).to have_page_heading "Sign In"
			expect(page).to have_selected_navigation 'Sign In'
		end
		
		scenario "successfully signs in as an account owner" do
			visit root_url
			
			# check that redirects to sign in page
			expect(page.current_url).to eq sign_in_url
		
			fill_in "Email", with: account.owner.email
			fill_in "Password", with: account.owner.password
			click_button "Sign in"
		
			expect(page).to have_success_message "Welcome #{account.owner.email}"
		
			# check redirects back to root
			expect(page.current_url).to eq root_url
			
			# check that shows current user's email
			expect(page).to have_content account.owner.email
			
			# check that shows Sign Out link
			expect(page).to have_link 'Sign Out', href: core.signout_path
		end
		
		scenario "with invalid password fails" do
			visit root_url
			
			# check that redirects to sign in page
			expect(page.current_url).to eq sign_in_url
			expect(page).to have_content 'Please sign in'
		
			fill_in "Email", with: account.owner.email
			fill_in "Password", with: 'invalid_password'
			click_button "Sign in"
		
			# check for error
			expect(page).to have_error_message "Invalid email or password"
		
			# check redirects back to sign in page
			expect(page.current_url).to eq sign_in_url
		end
		
		scenario "with invalid email address fails" do
			visit root_url
			
			# check that redirects to sign in page
			expect(page.current_url).to eq sign_in_url
			expect(page).to have_info_message 'Please sign in'
		
			fill_in "Email", with: 'invalid@example.com'
			fill_in "Password", with: 'password'
			click_button "Sign in"
		
			# check for error
			expect(page).to have_error_message "Invalid email or password"
		
			# check redirects back to sign in page
			expect(page.current_url).to eq sign_in_url
		end
		
		scenario "user cannot sign into a different subdomain" do
			other_account = FactoryGirl.create(:account)
			visit root_url
			
			# check that redirects to sign in page
			expect(page.current_url).to eq sign_in_url
			expect(page).to have_content 'Please sign in'
		
			fill_in "Email", with: other_account.owner.email
			fill_in "Password", with: other_account.owner.password
			click_button "Sign in"
		
			# check for error
			expect(page).to have_error_message "Invalid email or password"
		
			# check redirects back to sign in page
			expect(page.current_url).to eq sign_in_url
		end
	end

end