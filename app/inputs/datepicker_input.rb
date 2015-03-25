class DatepickerInput < SimpleForm::Inputs::Base

	def input(wrapper_options)
		template.content_tag(:div, class: 'input-group col-sm-3 col-md-3') do
			template.concat @builder.text_field(attribute_name, input_html_options)
			template.concat template.content_tag(:span, template.content_tag(:span, nil, class: 'glyphicon glyphicon-calendar'), class: 'input-group-addon')
		end
	end
	
	def input_html_options
		{ class: 'form-control datepicker', placeholder: 'MM/DD/YYYY' }
	end
	
end