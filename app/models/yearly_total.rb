class YearlyTotal < ApplicationRecord
	has_many :monthly_totals
	belongs_to :user
end
