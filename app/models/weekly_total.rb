class WeeklyTotal < ApplicationRecord
	belongs_to :user

	validates :week_start, :week_end, :mileage_total, :minutes, :seconds, :elevation_gain, presence: true
	validates :mileage_total, :elevation_gain, numericality: true
	validates :hours, numericality: true, length: { maximum: 3 }, allow_nil: true
	validates :minutes, numericality: true, length: { in: 0..2 }
	validates :seconds, numericality: true, length: { in: 1..2 }

	scope :order_by_oldest_week, -> {
	    order(:week_start)
	}

	scope :order_by_recent_week, -> {
	    order(week_start: :desc)
	}

	scope :of_user, -> (user) {
	    where(user: user)
	}

	scope :of_week, -> (week = DateTime.current) {
	    find_by("week_start <= ? AND week_end >= ?", week.beginning_of_week, week.end_of_week)
	}

	def calculate_goal_percentage
		@goal_percentage = (self.mileage_total/self.mileage_goal)*100
		@goal_percentage = @goal_percentage >= 100 ? 100 : @goal_percentage
	end

	def self.populate_pie_chart(user)
		@run_types = RunType.active_run_types
		pie_chart_data = []

		@run_types.each do |run_type|
			pie_chart_data << [run_type.name, run_type.runs.of_user(user).of_week(Date.current-1.week).count]
		end
		return pie_chart_data
	end
end
