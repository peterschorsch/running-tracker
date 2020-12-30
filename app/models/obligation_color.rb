class ObligationColor < ApplicationRecord
	has_many :obligations

	validates :name, :hex_code, presence: true
	validates :hex_code, length: { is: 7 }

	def self.default_record
		self.first
	end
end
