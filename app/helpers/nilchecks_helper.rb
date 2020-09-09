module NilchecksHelper
	### RETURNS A BOOLEAN ###
	def tf_check(field)
		return field.blank?
	end

	##### RETURNS N/A #####
	def nil_check(field)
		return tf_check(field) ? raw("<i>n/a</i>") : field
	end

	##### RETURNS N/A OR DATE #####
	def date_nil_check(field)
		return tf_check(field) ? raw("<i>n/a</i>") : formatDateDots(field)
	end

	##### CHECK IF IN ASSET PIPELINE ######
	def image_in_asset_pipeline(news)
		File.file? Rails.public_path + "/news_page/#{news.image_file_name}"
	end

end