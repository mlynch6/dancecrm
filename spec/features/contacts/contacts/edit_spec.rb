require 'rails_helper'

feature "Edit Contact" do
	include AuthenticationHelpers
	let!(:account) { FactoryGirl.create(:account) }
	let!(:contact) { FactoryGirl.create(:person, account: account) }
	let!(:page_url) { contacts.edit_contact_url(contact, :subdomain => account.subdomain) }
	
	scenario "has correct title & navigation highlighted" do
		sign_in_as(account.owner)
		visit page_url
		
		expect(page).to have_page_heading "Edit Contact"
		expect(page).to have_selected_navigation 'Contacts'
	end
		
	scenario "has correct fields on form" do
		sign_in_as(account.owner)
		visit page_url
		
		expect(page).to have_field 'First Name'
		expect(page).to have_field 'Middle Name'
		expect(page).to have_field 'Last Name'
		expect(page).to have_field 'Suffix'
		expect(page).to have_field 'Female'		#Gender
		expect(page).to have_field 'Male'			#Gender
		expect(page).to have_field 'Birth Date'
		expect(page).to have_field 'Email'
		expect(page).to have_field 'Status'
		
		expect(page).to have_button 'Save'
	end
	
	scenario "successfully saves a contact" do
		sign_in_as(account.owner)
		visit page_url
		
		fill_in "First Name", with: "Rudolf"
		fill_in "Middle Name", with: "Khametovich"
		fill_in "Last Name", with: "Nureyev"
		fill_in "Suffix", with: "I"
		choose "Male"
		fill_in "Birth Date", with: '3/17/1938'
		fill_in "Email", with: "nureyev@example.com"
		uncheck "Status"
		click_button "Save"
		
		expect(page).to have_success_message "Rudolf Khametovich Nureyev was successfully updated."
		
		contact.reload
		expect(contact.first_name).to eq "Rudolf"
		expect(contact.middle_name).to eq "Khametovich"
		expect(contact.last_name).to eq "Nureyev"
		expect(contact.suffix).to eq "I"
		expect(contact.gender).to eq "Male"
		expect(contact.birth_date).to eq Date.new(1938,3,17)
		expect(contact.email).to eq "nureyev@example.com"
		expect(contact.active).to be false
	end
	
	scenario "shows an error when required fields are not filled in" do
		sign_in_as(account.owner)
		visit page_url
		
		fill_in "First Name", with: ""
		fill_in "Last Name", with: ""
		click_button "Save"
		
		expect(page).to have_error_message "Please correct the following problems"
		expect(page).to have_error_message "First Name can't be blank"
		expect(page).to have_error_message "Last Name can't be blank"
	end
	
	scenario "shows an error when an invalid email is entered" do
		sign_in_as(account.owner)
		visit page_url
		
		fill_in "Email", with: "invalid"
		click_button "Save"
		
		expect(page).to have_error_message "Please correct the following problems"
		expect(page).to have_error_message "Email is not an email address"
	end
	
	scenario "shows an error when Birth Date is not in past" do
		sign_in_as(account.owner)
		visit page_url
		
		fill_in "Birth Date", with: (Date.today + 1.day).strftime('%m/%d/%Y')
		click_button "Save"
		
		expect(page).to have_error_message "Please correct the following problems"
		expect(page).to have_error_message "Birth Date must be in the past"
	end
	
	scenario "has correct navigation highlighted after an error" do
		sign_in_as(account.owner)
		visit page_url
		
		fill_in "First Name", with: ""
		click_button "Save"
		
		expect(page).to have_error_message "Please correct the following problems"
		expect(page).to have_selected_navigation 'Contacts'
	end
	
	scenario "Cancel link redirects back to Contacts List" do
		sign_in_as(account.owner)
		visit page_url
		click_link "Cancel"
		
		# check that redirects to Contact List
		expect(page.current_url).to eq contacts.contacts_url(:subdomain => account.subdomain)
	end
	
	scenario "cannot edit another account's contact" do
		account_b = FactoryGirl.create(:account)
		contact_b = FactoryGirl.create(:person, account: account_b)
		
		sign_in_as(account.owner)
		visit contacts.edit_contact_url(contact_b, :subdomain => account.subdomain)

		# check that redirects to Contact List
		expect(page.current_url).to eq contacts.contacts_url(:subdomain => account.subdomain)
		expect(page).to have_info_message "Record not found"
	end
	
	scenario "user must be signed in to view page" do
		visit page_url
		
		# check that redirects to sign in page
		expect(page.current_url).to eq core.sign_in_url(:subdomain => account.subdomain)
		expect(page).to have_info_message 'Please sign in'
	end
end