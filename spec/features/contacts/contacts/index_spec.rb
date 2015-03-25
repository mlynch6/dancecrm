require 'rails_helper'

feature "Contacts List" do
	include AuthenticationHelpers
	let!(:account) { FactoryGirl.create(:account) }

	scenario "has correct title & navigation highlighted" do
		sign_in_as(account.owner)
		visit contacts.contacts_url(:subdomain => account.subdomain)
		
		expect(page).to have_page_heading "Contact Search"
		expect(page).to have_selected_navigation 'Contacts'
		expect(page).to have_selected_navigation 'Search Contacts'
	end
		
	scenario "has correct table headers" do
		sign_in_as(account.owner)
		visit contacts.contacts_url(:subdomain => account.subdomain)
		
		expect(page).to have_css 'th', text: 'Name'
		expect(page).to have_css 'th', text: 'Birth Date'
		expect(page).to have_css 'th', text: 'Type'
		expect(page).to have_css 'th', text: 'Email'
	end
	
	scenario "displays contact details in table" do
		3.times do
			FactoryGirl.create(:person, account: account)
		end
		
		sign_in_as(account.owner)
		visit contacts.contacts_url(:subdomain => account.subdomain, per_page: 2)
		records = Contacts::Person.scoped_to(account).limit(2)
		
		expect(records.count).to eq 2
		records.each do |person|
			expect(page).to have_css 'td', text: person.name
			expect(page).to have_css 'td', text: person.birth_date.strftime('%-m/%-d/%Y') if person.birth_date.present?
			expect(page).to have_css 'td', text: person.contact_type
			expect(page).to have_css 'td', text: person.email
			
			expect(page).to have_link 'Edit', href: contacts.edit_contact_path(person)
			expect(page).to have_link 'Delete', href: contacts.contact_path(person)
		end
		expect(page).to have_pagination
	end
	
	scenario "displays only current account's contacts" do
		person = FactoryGirl.create(:person, account: account)
		account_b = FactoryGirl.create(:account)
		person_b = FactoryGirl.create(:person, account: account_b)
		
		sign_in_as(account.owner)
		visit contacts.contacts_url(:subdomain => account.subdomain)

		expect(page).to have_content person.name
		expect(page).not_to have_content person_b.name
	end
	
	# it "has correct Active/Inactive/All filter highlighting" do
	# 	select "Inactive", from: 'status'
	# 	click_button 'Search'
	# 	should have_selector 'h1 small', text: 'Inactive'
	#
	# 	select "Active", from: 'status'
	# 	click_button 'Search'
	# 	should have_selector 'h1 small', text: 'Active'
	#
	# 	select "All", from: 'status'
	# 	click_button 'Search'
	# 	should have_selector 'h1 small', text: 'All'
	#
	# 	visit employees_path(status: "invalid")
	# 	should have_selector 'h1 small', text: 'All'
	# end
	#
	# it "without records" do
	# 	person = current_user.person
	# 	person.inactivate
	#   	visit employees_path
	#
	#     should have_selector 'p', text: 'To begin'
	# 	should_not have_selector 'td'
	# 	should_not have_selector 'div.pagination'
	# end
	#
	# describe "can search" do
	# 	before do
	# 		4.times { FactoryGirl.create(:person, account: current_account) }
	# 		4.times { FactoryGirl.create(:person, :inactive, account: current_account) }
	# 		@rhino = FactoryGirl.create(:person, account: current_account, first_name: 'Maxwell', last_name: 'Rhinoceros')
	# 		visit employees_path
	# 	end
	#
	# 	it "for active records" do
	# 		select "Active", from: 'status'
	# 		click_button 'Search'
	#
	# 		Employee.active.each do |employee|
	# 			should have_selector 'td', text: employee.name
	# 			should have_selector 'td', text: 'Active'
	# 			should_not have_selector 'td', text: 'Inactive'
	#
	# 			should have_link 'Inactivate', href: inactivate_employee_path(employee)
	#     end
	# 	end
	#
	# 	it "for inactive records" do
	# 		select "Inactive", from: 'status'
	# 		click_button 'Search'
	#
	# 		Employee.inactive.each do |employee|
	# 			should have_selector 'td', text: employee.name
	# 			should_not have_selector 'td', text: 'Active'
	# 			should have_selector 'td', text: 'Inactive'
	#
	# 			should have_link 'Activate', href: activate_employee_path(employee)
	#     end
	# 	end
	#
	# 	it "for all records" do
	# 		select "All", from: 'status'
	# 		click_button 'Search'
	#
	# 		Employee.all.each do |employee|
	# 			should have_selector 'td', text: employee.name
	# 			should have_selector 'td', text: 'Active'
	# 			should have_selector 'td', text: 'Inactive'
	#     end
	# 	end
	#
	# 	it "on First Name" do
	# 		fill_in "fname", with: 'Max'
	# 		click_button 'Search'
	#
	# 		should have_selector 'tr', count: 2
	# 		should have_selector 'td', text: @rhino.name
	# 	end
	#
	# 	it "on Last Name" do
	# 		fill_in "lname", with: 'Rhino'
	# 		click_button 'Search'
	#
	# 		should have_selector 'tr', count: 2
	# 		should have_selector 'td', text: @rhino.name
	# 	end
	# end
	
	scenario "user must be signed in to view page" do
		visit contacts.contacts_url(:subdomain => account.subdomain)
		
		# check that redirects to sign in page
		expect(page.current_url).to eq core.sign_in_url(:subdomain => account.subdomain)
		expect(page).to have_content 'Please sign in'
	end
end