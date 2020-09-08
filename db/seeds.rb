start = Time.now
puts "---------------STARTED SEEDING---------------"
puts ""

puts "----------ADMINS----------"
@admin_user = User.create_with(first_name: "Peter", last_name: "Schorsch", active: true, password_digest: User.digest("Peteschorsch1!"), role: "Admin").find_or_create_by(email: "peteschorsch@gmail.com")
puts @admin_user.inspect

puts ""

puts "RAN SEEDING IN " + (Time.now - start).round(1).to_s + " SECONDS"
