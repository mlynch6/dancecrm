require 'rails_helper'

feature "Destroy Contact" do
	include AuthenticationHelpers
	let!(:account) { FactoryGirl.create(:account) }
	let!(:contact) { FactoryGirl.create(:person, account: account) }
	let!(:page_url) { contacts.contacts_url(:subdomain => account.subdomain) }
	
	scenario "successfully deletes a contact" do
		sign_in_as(account.owner)
		visit page_url
		
		click_link "delete_#{contact.id}"
		
		expect(page).to have_success_message "#{contact.full_name} was deleted."
		
		# check that redirects to Contact List
		expect(page.current_url).to eq contacts.contacts_url(:subdomain => account.subdomain)
		
		# check that record not there
		expect(page).not_to have_content contact.name
	end
end