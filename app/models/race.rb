class Race < ApplicationRecord
	belongs_to :race_distance
	belongs_to :state
	belongs_to :gear

	validates :race, :race_datetime, :hours, :minutes, :seconds, :pace, :city, :bib_number, presence: true
	validates :hours, length: { in: 0..3 }
	validates :minutes, length: { in: 0..2 }
	validates :seconds, length: { in: 1..2 }
	
end
