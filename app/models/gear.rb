class Gear < ApplicationRecord
	belongs_to :user
	belongs_to :shoe_brand
	has_many :runs

	has_attached_file :image
	validates_attachment_presence :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	validates :model, :color_way, :forefoot_stack, :heel_stack, :heel_drop, :weight, :size, :shoe_type, :purchased_on, presence: true
	validates :model, :uniqueness => { :scope => [:shoe_brand_id, :color_way, :user_id] }, :if => :model_changed?
	validates :forefoot_stack, :heel_stack, :heel_drop, length: { maximum: 2 }
	validates :weight, :size, length: { maximum: 4 }

	default_scope -> { includes(:shoe_brand).order("shoe_brands.brand, gears.model") }

	scope :find_shoe, -> (shoe_model) {
		find_by(model: shoe_model)
	}

	scope :find_shoe_with_color, -> (shoe_model, color_way) {
		find_by(model: shoe_model, color_way: color_way)
	}

	scope :of_user, -> (user) {
	    where(user: user)
	}

	scope :active_shoes, -> {
		where(:retired => false)
	}

	scope :retired_shoes, -> {
		where(:retired => true)
	}

	scope :remove_default_shoe, -> {
		where(:default => false)
	}

	scope :return_default_shoe, -> {
		find_by(:default => true)
	}

	def is_retired?
		self.retired
	end

	def self.select_gear_id_name
		self.unscoped.active_shoes.includes(:shoe_brand).order(default: :desc, brand: :asc).map{ |gear| [gear.return_full_shoe_name, gear.id] }
	end

	### ADDING NEW MILEAGE FROM A RUN TO SHOE ###
	def add_mileage_to_shoe(mileage)
		self.mileage += mileage
		self.save(:validate => false)
	end

	def subract_mileage_to_shoe(mileage)
		self.mileage -= mileage
		self.save(:validate => false)
	end

	### UPDATING MILEAGE FROM A RUN OF SHOE ###
	def update_mileage_of_shoe(updated_mileage)
		#self.runs.where.not(:id => self.id).each { |run| updated_mileage += run.mileage_total.to_f }
		self.mileage = updated_mileage
		self.save!(:validate => false)
	end

	### UPDATING MILEAGE FROM A RUN OF SHOE ###
	def self.recalculate_mileage_of_shoe(user)
		user.gears.each do |gear|
			gear.update_mileage_of_shoe(gear.runs.sum(:mileage_total))
		end
	end

	def self.return_random_gear_id
		gear = Gear.remove_default_shoe
		return gear_id = gear.offset(rand(gear.count)).first.id
	end

	def set_new_default
		Gear.select(:id, :default).where.not(:id => self.id).update_all(default: false)
	end

	def unretire_shoe
		self.retired = false
		self.retired_on = nil
		self.save(:validate => false)
	end

	def retire_shoe
		self.default = false
		@active_default_shoes = Gear.active_shoes.where(:default => true)
		Gear.return_default_shoe.update_attribute("default", true) if @active_default_shoes.empty?
		self.save(:validate => false)
	end

	### DISPLAY METHODS ###
	def return_full_shoe_name
		self.shoe_brand.brand + " " + self.model
	end

	def return_shoe_stack_height
		self.forefoot_stack.to_s + "mm/" + self.heel_stack.to_s + "mm"
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

end
