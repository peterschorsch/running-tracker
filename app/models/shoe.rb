class Shoe < ApplicationRecord
	belongs_to :user
	belongs_to :shoe_brand
	has_many :runs

	before_save :calculate_heel_drop, if: ->(obj){ obj.forefoot_stack_changed? or obj.heel_stack_changed? }
	before_save :calculate_total_mileage

	has_attached_file :image
	validates_attachment_presence :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	validates :model, :color_way, :forefoot_stack, :heel_stack, :heel_drop, :weight, :size, :shoe_type, :purchased_on, presence: true
	validates :model, :uniqueness => { :scope => [:shoe_brand_id, :color_way, :user_id] }, :if => :model_changed?
	validates :forefoot_stack, :heel_stack, numericality: true
	validates :heel_drop, :weight, :size, length: { maximum: 4 }

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

	def self.select_shoe_id_name
		self.active_shoes.includes(:shoe_brand).order(default: :desc, brand: :asc).map{ |shoe| [shoe.return_full_shoe_name, shoe.id] }
	end

	### FORM SELECTS ###
	def self.shoe_size_select
		(7..12).step(0.5).map {|i| ["M " + i.to_s, i] }
	end

	def self.weight_select
		(4..12).step(0.1.to_d).map {|i| [i.to_s + " oz", i] }
	end

	def self.forefoot_stack_select
		(10..40).step(0.5.to_d).map {|i| [i.to_s + " mm", i] }
	end

	def self.heel_stack_select
		(15..40).step(0.5.to_d).map {|i| [i.to_s + " mm", i] }
	end

	### ADDING NEW MILEAGE TO A SHOE ###
	def add_mileage_to_shoe(mileage)
		self.total_mileage += mileage
		self.save(:validate => false)
	end

	### SUBRACT MILEAGE FROM A SHOE ###
	def subract_mileage_from_shoe(mileage)
		self.total_mileage -= mileage
		self.save(:validate => false)
	end

	### UPDATING MILEAGE FROM A RUN OF SHOE ###
	def self.recalculate_mileage_of_shoes(user)
		user.return_completed_runs.each { |run| run.shoe.update_columns(:total_mileage => run.shoe.runs.sum(:mileage_total)) }
	end

	### UPDATING TOTAL MILEAGE FROM A RUN OF SHOE ###
	def update_mileage_of_shoe(updated_total_mileage)
		self.update_columns(:total_mileage => updated_total_mileage)
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
	def calculate_total_mileage
		self.total_mileage = self.previous_mileage + self.new_mileage
	end

end
