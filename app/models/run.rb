class Run < ApplicationRecord
	belongs_to :user
	belongs_to :weekly_total, optional: true
	belongs_to :gear
	belongs_to :state
end
