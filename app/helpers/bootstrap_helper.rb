module BootstrapHelper
	def icon(name)
		content_tag :span, nil, class: "glyphicon glyphicon-#{name}"
	end
	
	def icon_link_to(icon_name, name = nil, options = nil, html_options = nil, &block) 
		text = icon(icon_name)+' '+name
		link_to(text, options, html_options, &block)
	end
	
	def form_actions
		content_tag :div, class:"form-group actions" do
	    content_tag :div, class: "col-sm-offset-3 col-md-offset-3 col-sm-9 col-md-9" do
				yield
			end
		end
	end
end
