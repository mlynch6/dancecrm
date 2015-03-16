RSpec::Matchers.define :have_error_message do |expected_message|
	match do |page|
		expect(page).to have_css 'div.alert-danger', text: expected_message
	end

	failure_message do |page|
		"expected error message '#{expected_message}'"
  end

	failure_message_when_negated do |page|
		"expected to not see error message '#{expected_message}'"
	end
end