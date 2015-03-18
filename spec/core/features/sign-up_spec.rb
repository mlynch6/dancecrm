require 'rails_helper'

feature "Account Sign-Up" do
	scenario "when sign-up is a success it creates an account and logs the user into subdomain" do
		visit core.root_path
		click_link "Sign Up"
		
		fill_in "Name", with: "Test"
		fill_in "Subdomain", with: "abc"
		fill_in "Email", with: "test@example.com"
		fill_in "Password", with: "password"
		fill_in "Password Confirmation", with: "password"
		click_button "Create Account"
		
		expect(page).to have_success_message "Your account was successfully created."
		
		# check user logged in
		expect(page).to have_content 'test@example.com'
		
		# check redirected to subdomain
		expect(page.current_url).to eq 'http://abc.example.com/'
	end
	
	scenario "shows error when unsuccessful" do
		visit core.root_path
		click_link "Sign Up"
		
		fill_in "Name", with: ""
		fill_in "Subdomain", with: "abc"
		fill_in "Email", with: "test@example.com"
		fill_in "Password", with: "password"
		fill_in "Password Confirmation", with: "password"
		click_button "Create Account"
		
		expect(page).to have_error_message "Please correct the following problems"
	end
	
	scenario "shows an error when subdomain is not unique" do
		FactoryGirl.create(:account, subdomain: 'abc')
		visit core.root_path
		click_link "Sign Up"
		
		fill_in "Name", with: "Test"
		fill_in "Subdomain", with: "abc"
		fill_in "Email", with: "test@example.com"
		fill_in "Password", with: "password"
		fill_in "Password Confirmation", with: "password"
		click_button "Create Account"
		
		expect(page).to have_error_message "Please correct the following problems"
		expect(page).to have_error_message 'Subdomain has already been taken'
	end
	
	scenario "shows an error when subdomain uses restricted word" do
		visit core.root_path
		click_link "Sign Up"
		
		fill_in "Name", with: "Test"
		fill_in "Subdomain", with: "admin"
		fill_in "Email", with: "test@example.com"
		fill_in "Password", with: "password"
		fill_in "Password Confirmation", with: "password"
		click_button "Create Account"
		
		expect(page).to have_error_message "Please correct the following problems"
		expect(page).to have_error_message 'Subdomain is not allowed. Please choose another subdomain'
	end
	
	scenario "shows an error when subdomain uses restricted characters" do
		visit core.root_path
		click_link "Sign Up"
		
		fill_in "Name", with: "Test"
		fill_in "Subdomain", with: "abc<100"
		fill_in "Email", with: "test@example.com"
		fill_in "Password", with: "password"
		fill_in "Password Confirmation", with: "password"
		click_button "Create Account"
		
		expect(page).to have_error_message "Please correct the following problems"
		expect(page).to have_error_message 'Subdomain is not allowed. Please choose another subdomain'
	end
end