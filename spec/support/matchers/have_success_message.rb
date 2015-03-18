RSpec::Matchers.define :have_success_message do |expected_message|
	match do |page|
		expect(page).to have_css 'div.alert-success', text: expected_message
	end

	failure_message do |page|
		"expected success message '#{expected_message}'"
  end

	failure_message_when_negated do |page|
		"expected to not see success message '#{expected_message}'"
	end
end