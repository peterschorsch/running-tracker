class Gear < ApplicationRecord
	belongs_to :shoe_brand
	has_many :races

	has_attached_file :image
	validates_attachment_presence :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	validates :model, :color_way, :heel_drop, :weight, :size, :shoe_type, :purchased_on, presence: true
	validates :model, :uniqueness => { :scope => [:shoe_brand_id, :color_way] }, :if => :model_changed?
	validates :heel_drop, length: { maximum: 2 }
	validates :weight, :size, length: { maximum: 4 }
	validate :retired_fields

	scope :find_shoe, -> (shoe_model) {
		find_by(model: shoe_model)
	}

	scope :find_shoe_with_color, -> (shoe_model, color_way) {
		find_by(model: shoe_model, color_way: color_way)
	}

	scope :order_by_shoe, -> {
		joins(:shoe_brand).order(:brand, :model)
	}

	scope :active_shoes, -> {
		where(:retired => false)
	}

	scope :retired_shoes, -> {
		where(:retired => true)
	}

	scope :remove_default_shoe, -> {
		where.not(:model => "RUNNING SHOE")
	}

	scope :default_shoe, -> {
		find_by(:model => "RUNNING SHOE")
	}

	def return_shoe_name
		self.shoe_brand.brand + " " + self.model
	end

	def return_shoe_drop
		self.heel_drop.to_s + "mm"
	end

	def return_shoe_weight
		self.weight.to_s + "oz"
	end

	def return_shoe_mileage
		self.mileage.to_s + " miles"
	end

	def set_new_default
		Gear.select(:id, :default).where.not(:id => self.id).update_all(default: false)
	end

	def unretire_shoe
		self.retired_on = nil
	end

	def retire_shoe
		self.default = false
		@active_default_shoes = Gear.active_shoes.where(:default => true)
		Gear.default_shoe.update_attribute("default", true) if @active_default_shoes.empty?
	end

	def retired_fields
		#puts self.retired
	end

end
