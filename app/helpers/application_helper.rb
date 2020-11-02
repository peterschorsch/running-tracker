module ApplicationHelper
	def determine_progress_bar_text_color(weekly_total)
		weekly_total.mileage_total.to_i == 0 ? "#33333" : "white"
	end
end
