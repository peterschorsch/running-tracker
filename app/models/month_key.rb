class MonthKey < ApplicationRecord
	validates :number, :name, presence: true, uniqueness: true
	validates :number, numericality: true, length: { is: 1 }
end
