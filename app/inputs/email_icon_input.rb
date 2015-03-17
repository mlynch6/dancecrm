class EmailIconInput < SimpleForm::Inputs::Base

	def input(wrapper_options)
		template.content_tag(:div, class: 'input-group') do
			template.concat template.content_tag(:span, template.content_tag(:span, nil, class: 'glyphicon glyphicon-envelope'), class: 'input-group-addon')
			template.concat @builder.email_field(attribute_name, input_html_options)
		end
	end
	
	def input_html_options
		{ class: 'form-control' }
	end
	
end