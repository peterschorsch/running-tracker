class AllTimeTotal < ApplicationRecord
	has_many :yearly_totals
	belongs_to :user
end
