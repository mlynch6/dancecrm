RSpec::Matchers.define :have_pagination do |expected_message|
	match do |page|
		expect(page).to have_css 'div.pagination'
	end

	failure_message do |page|
		"expected page to have pagination"
  end

	failure_message_when_negated do |page|
		"expected page not to have pagination"
	end
end