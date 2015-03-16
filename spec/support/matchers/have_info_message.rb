RSpec::Matchers.define :have_info_message do |expected_message|
	match do |page|
		expect(page).to have_css 'div.alert-info', text: expected_message
	end

	failure_message do |page|
		"expected info message '#{expected_message}'"
  end

	failure_message_when_negated do |page|
		"expected to not see info message '#{expected_message}'"
	end
end