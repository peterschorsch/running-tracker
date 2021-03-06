class Shoe < ApplicationRecord
	belongs_to :user
	belongs_to :shoe_brand
	has_many :runs

	has_attached_file :image
	validates_attachment_presence :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	validates :model, :color_way, :forefoot_stack, :heel_stack, :heel_drop, :shoe_type, :purchased_on, presence: true
	validates :model, :uniqueness => { :scope => [:shoe_brand_id, :color_way, :user_id] }, :if => :model_changed?
	validates :forefoot_stack, :heel_stack, numericality: true
	validates :forefoot_stack, :heel_stack, :heel_drop, :weight, :size, length: { maximum: 4 }

	before_save :calculate_heel_drop, if: ->(obj){ obj.forefoot_stack_changed? or obj.heel_stack_changed? }
	before_save :calculate_mileage_total, :trim_fields

	scope :of_user, -> (user) {
	    where(user: user)
	}

	scope :find_shoe, -> (shoe_model) {
		find_by(model: shoe_model)
	}

	scope :find_shoe_with_color, -> (shoe_model, color_way) {
		find_by(model: shoe_model, color_way: color_way)
	}

	scope :active_shoes, -> {
		where(:retired => false)
	}

	scope :retired_shoes, -> {
		where(:retired => true)
	}

	scope :return_default_shoe, -> {
		find_by(:default => true)
	}

	scope :remove_default_shoe, -> {
		where(:default => false)
	}

	scope :order_by_model_brand, -> {
		includes(:shoe_brand).order(default: :desc).order('shoe_brands.brand')
	}

	### DISPLAY METHODS ###
	def return_full_shoe_name
		self.shoe_brand.brand + " " + self.model
	end

	def is_default_shoe?
		self.default
	end

	def is_retired?
		self.retired
	end

	def self.select_new_shoe_id_name
		self.active_shoes.order_by_model_brand.map{ |shoe| [shoe.return_full_shoe_name, shoe.id] }
	end

	def self.select_edit_shoe_id_name
		self.order_by_model_brand.map{ |shoe| [shoe.return_full_shoe_name, shoe.id] }
	end

	def self.return_random_shoe
		active_shoes.sample
	end

	### FORM SELECTS ###
	def self.shoe_size_select
		(7..12).step(0.5).map {|i| ["M " + i.to_s, i] }
	end

	def self.weight_select
		(4..12).step(0.1.to_d).map {|i| [i.to_s + " oz", i] }
	end

	def self.forefoot_stack_select
		(0..40).step(0.5.to_d).map {|i| [i.to_s + " mm", i] }
	end

	def self.heel_stack_select
		(0..40).step(0.5.to_d).map {|i| [i.to_s + " mm", i] }
	end

	### ADDING NEW MILEAGE TO A SHOE ###
	def add_mileage_to_shoe(mileage_of_run)
		self.mileage_total += mileage_of_run
		self.save(:validate => false)
	end

	### SUBRACT MILEAGE FROM A SHOE ###
	def subract_mileage_from_shoe(mileage_of_run)
		self.mileage_total -= mileage_of_run
		self.save(:validate => false)
	end

	### UPDATING MILEAGE OF A SUNGULAR SHOE ###
	def recalculate_new_mileage_singlular_shoe
		new_mileage_of_shoe = self.runs.completed_runs.sum(:mileage_total)
		self.update_columns(:new_mileage => new_mileage_of_shoe, :mileage_total => self.previous_mileage + new_mileage_of_shoe)
	end

	def remove_other_default_shoes
		Shoe.select(:id, :default).where.not(:id => self.id).update_all(default: false)
	end

	def unretire_shoe
		self.retired = false
		self.retired_on = nil
		self.save(:validate => false)
	end

	def retire_shoe
		self.default = false
		@active_default_shoes = Shoe.active_shoes.where(:default => true)
		Shoe.return_default_shoe.update_attribute("default", true) if @active_default_shoes.empty?
		self.save(:validate => false)
	end

	private
	### SUBTRACT FOREFOOT STACK HEIGHT FROM HEEL STACK HEIGHT TO CALCULATE HEEL DROP ###
	def calculate_heel_drop
		self.heel_drop = self.heel_stack - self.forefoot_stack
	end

	### ADD MILEAGE FIELDS TOGETHER ###
	def calculate_mileage_total
		self.mileage_total = self.previous_mileage + self.new_mileage
	end

	def trim_fields
		self.weight = "0" if self.weight.blank?
		self.size = "0" if self.size.blank?
	end

end
