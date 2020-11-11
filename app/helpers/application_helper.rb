module ApplicationHelper
	def determine_progress_bar_text_color(weekly_total)
		weekly_total.mileage_total.to_i == 0 ? "#33333" : "white"
	end

	### TEXT THAT WILL DISPLAY ON WEB BROWSER TAB ###
	def return_tab_name
		return "Run Tracker"
	end

	### ICON THAT IS DISPLAYED NEXT TO TAB NAME IN WEB BROWSER TAB ###
	def return_tab_icon
		asset_path('logos/tab_runner_icon.png')
	end
end
