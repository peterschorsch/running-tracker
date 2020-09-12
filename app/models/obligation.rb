class Obligation < ApplicationRecord
	belongs_to :state

	validates :name, :start_datetime, :end_datetime, :city, presence: true

	scope :order_by_newest_date_time, -> {
		order('start_datetime ASC, end_datetime ASC')
	}

	scope :order_by_oldest_date_time, -> {
		order(:start_datetime, :end_datetime)
	}

	#October 10, 2017
	def return_formatted_date
		self.start_datetime.strftime("%B %-d, %Y")
	end

	# 4:38pm - 5:38pm
	def return_formatted_time_period
		self.start_datetime.strftime("%-I:%M%p") + " - " + self.end_datetime.strftime("%-I:%M%p")
	end
end
