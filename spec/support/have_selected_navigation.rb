RSpec::Matchers.define :have_selected_navigation do |nav_text|
	match do |page|
		expect(page).to have_css 'li.active', text: nav_text
	end

	failure_message do |page|
		"expected navigation '#{nav_text}' to be selected"
  end

	failure_message_when_negated do |page|
		"expected navigation '#{nav_text}' not to be selected"
	end
end