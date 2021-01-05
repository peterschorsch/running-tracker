module ShoeHelper
	def return_full_shoe_name(shoe)
		shoe.shoe_brand.brand + " " + shoe.model
	end

	def return_shoe_stack_height(shoe)
		raw("<strong>#{shoe.forefoot_stack}</strong>") + "/" + raw("<strong>#{shoe.heel_stack}</strong>") + "mm"
	end

	def return_shoe_drop(shoe_heel_drop)
		raw("<strong>#{shoe_heel_drop}</strong>") + "mm"
	end

	def return_shoe_weight(shoe_weight)
		raw("<strong>#{shoe_weight}</strong>") + "oz"
	end

	def return_shoe_mileage(shoe_mileage)
		raw("<strong>#{shoe_mileage}</strong>").to_s + " miles"
	end

end