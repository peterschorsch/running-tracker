class MonthlyTotal < ApplicationRecord
	belongs_to :yearly_total
	has_many :weekly_totals
end
