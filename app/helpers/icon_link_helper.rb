module IconLinkHelper
	
	def link_with_icon(link_name, path, glyph_name)
		link_to("#{glyphicon_span(glyph_name)} #{link_name}".html_safe, path, class: "top-bottom-padding")
	end

	def dropdown_link_with_icon(link_name, path, glyph_name)
    	link_to("#{glyphicon_span(glyph_name)} #{link_name}".html_safe, path, class: "top-bottom-padding")
  	end

	private

	def glyphicon_span(glyph_name)
		"<span class='glyphicon glyphicon-#{glyph_name}'></span>"
	end
end