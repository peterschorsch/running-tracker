class ObligationColor < ApplicationRecord
	has_many :obligations

	validates :name, :hex_code, presence: true
	validates :hex_code, length: { is: 7 }
end
