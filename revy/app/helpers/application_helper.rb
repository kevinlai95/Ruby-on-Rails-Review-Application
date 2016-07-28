module ApplicationHelper
	# Returns the full title on a per-page basis.
    def full_title(page_title = '')
    	base_title = "Revy - Reviews you can trust"
    	return base_title if page_title.empty?
    	return page_title + " | " + base_title
  	end
end
