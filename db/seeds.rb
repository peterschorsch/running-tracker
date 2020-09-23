 start = Time.now
puts "---------------STARTED SEEDING---------------"
puts ""

puts "----------USERS----------"
@my_admin_user = User.create_with(first_name: "Peter", last_name: "Schorsch", active: true, password_digest: User.digest("Peteschorsch1!"), role: "Admin").find_or_create_by(email: "peteschorsch@gmail.com")
puts @my_admin_user.inspect
@user = User.create_with(first_name: "Website", last_name: "Viewer", active: true, password_digest: User.digest("Websiteviewer1!"), role: "Viewer").find_or_create_by(email: "peteschorsch@icloud.com")
puts @user.inspect
puts ""
puts ""

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

puts "RAN SEEDING IN " + (Time.now - start).round(1).to_s + " SECONDS"
