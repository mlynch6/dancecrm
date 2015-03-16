RSpec::Matchers.define :have_page_heading do |expected_heading|
	match do |page|
		expect(page).to have_css 'h1', text: expected_heading
	end

	failure_message do |page|
		"expected heading '#{expected_heading}'"
  end

	failure_message_when_negated do |page|
		"expected to not see heading '#{expected_heading}'"
	end
end