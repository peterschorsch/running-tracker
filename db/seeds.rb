 start = Time.now
puts "---------------STARTED SEEDING---------------"
puts ""

puts "----------USER ROLES----------"
@user_role = UserRole.find_or_create_by(name: "Admin", :administrator => true, :user => false, :website_viewer => false)
puts @user_role.inspect
@user_role = UserRole.find_or_create_by(name: "User", :administrator => false, :user => true, :website_viewer => false)
puts @user_role.inspect
@user_role = UserRole.find_or_create_by(name: "Website Viewer", :administrator => false, :user => false, :website_viewer => true)
puts @user_role.inspect
puts ""

puts "----------USERS----------"
@my_admin_user = User.create_with(first_name: "Peter", last_name: "Schorsch", default_city: "Los Angeles", default_state: "California", :default_country => "USA", time_zone: "Pacific Time (US & Canada)",  active: true, password_digest: User.digest("Peteschorsch1!"), user_role_id: UserRole.return_admin_user_role.id).find_or_create_by(email: "peteschorsch@gmail.com")
puts @my_admin_user.inspect
@website_user = User.create_with(first_name: "Website", last_name: "Viewer", active: true, :last_login => DateTime.now, default_city: "Los Angeles", default_state: "California", :default_country => "USA", time_zone: "Pacific Time (US & Canada)", password_digest: User.digest("Websiteviewer1!"), user_role_id: UserRole.return_website_viewer_role.id).find_or_create_by(email: "peteschorsch@icloud.com")
puts @website_user.inspect
puts ""
puts ""

Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }

puts "RAN SEEDING IN " + (Time.now - start).round(1).to_s + " SECONDS"
