class WeeklyTotal < ApplicationRecord
	belongs_to :monthly_total
	has_many :runs
end
