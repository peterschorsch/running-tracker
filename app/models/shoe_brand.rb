class ShoeBrand < ApplicationRecord
	has_many :shoes, dependent: :destroy

	validates :brand, presence: true, uniqueness: true

	default_scope -> { order(brand: :asc) }

	scope :named, -> (brand) {
		find_by(:brand => brand)
	}

	scope :remove_default_brand, -> {
		where.not(:model => "DEFAULT")
	}

	def self.select_shoe_id_name
		self.all.map{ |brand| [brand.brand, brand.id] }
	end
end
