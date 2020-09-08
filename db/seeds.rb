start = Time.now
puts "---------------STARTED SEEDING---------------"
puts ""

puts "----------ADMINS----------"
@admin_user = User.create_with(first_name: "Peter", last_name: "Schorsch", active: true, password_digest: User.digest("Peteschorsch1!"), role: "Admin").find_or_create_by(email: "peteschorsch@gmail.com")
puts @admin_user.inspect
puts ""

puts "----------SHOW BRANDS----------"
shoe_brands = ["Addias", "Altra", "ASICS", "Brooks", "Hoka One One", "Mizuno", "Newton", "New Balance", "Nike", "On", "Saloman", "Saucony"]
shoe_brands.each do |brand|
	@shoe = ShoeBrand.create_with(:brand => brand).find_or_create_by(:brand => brand)
	puts @shoe.inspect
end
puts ""


puts "RAN SEEDING IN " + (Time.now - start).round(1).to_s + " SECONDS"
