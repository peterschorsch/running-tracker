 start = Time.now
puts "---------------STARTED SEEDING---------------"
puts ""

puts "----------ADMINS----------"
@my_admin_user = User.create_with(first_name: "Peter", last_name: "Schorsch", active: true, password_digest: User.digest("Peteschorsch1!"), role: "Admin").find_or_create_by(email: "peteschorsch@gmail.com")
puts @my_admin_user.inspect
@user = User.create_with(first_name: "Normal", last_name: "User", active: true, password_digest: User.digest("Normaluser1!"), role: "User").find_or_create_by(email: "peteschorsch@icloud.com")
puts @user.inspect
puts ""
puts ""

puts "----------SHOW BRANDS----------"
shoe_brands = ["Adidas", "Altra", "ASICS", "Brooks", "DEFAULT", "Hoka One One", "Mizuno", "Newton", "New Balance", "Nike", "On", "Saloman", "Saucony"]
shoe_brands.each do |brand|
	@shoe = ShoeBrand.create_with(:brand => brand).find_or_create_by(:brand => brand)
	puts @shoe.inspect
end
puts ""
puts ""

puts "----------GEAR----------"
adidias_id = ShoeBrand.named("Adidas").id
alta_id = ShoeBrand.named("Altra").id
brooks_id = ShoeBrand.named("Brooks").id
nike_id = ShoeBrand.named("Nike").id
on_id = ShoeBrand.named("On").id
saucony_id = ShoeBrand.named("Saucony").id

model = "RUNNING SHOE"
color_way = "White"
image_path = "#{Rails.root}/app/assets/images/shoes/stock_shoe.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => ShoeBrand.named("DEFAULT").id, :model => model, :color_way => color_way, :forefoot_stack => 0, :heel_stack => 0, :heel_drop => 0, :mileage => 0, :weight => 0, :size => 8.5, :shoe_type => "Neutral", :default => true, :purchased_on => Date.today, :first_used_on => Date.today,
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Adios 4"
color_way = "Core Black/Cloud White"
image_path = "#{Rails.root}/app/assets/images/shoes/adios_4.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => adidias_id, :model => model, :color_way => color_way, :forefoot_stack => 17, :heel_stack => 27, :heel_drop => 10, :mileage => 107.9, :weight => 9.4, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 8, 12), :first_used_on => Date.new(2019, 10, 6),
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect
model = "Adios 4 (Pair 2)"
@gear = Gear.create_with(:shoe_brand_id => adidias_id, :model => model, :color_way => color_way, :forefoot_stack => 17, :heel_stack => 27, :heel_drop => 10, :weight => 9.4, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 3, 15), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Escalante 2"
color_way = "Gray"
image_path = "#{Rails.root}/app/assets/images/shoes/escalante_2.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => alta_id, :model => model, :color_way => color_way, :heel_drop => 0, :mileage => 259.7, :weight => 9.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 23), :first_used_on => Date.new(2019, 9, 25), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect
model = "Escalante 2 (Pair 2)"
@gear = Gear.create_with(:shoe_brand_id => alta_id, :model => model, :color_way => color_way, :heel_drop => 0, :mileage => 0, :weight => 9.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 6, 17), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Ravenna 8"
color_way = "Red/White"
image_path = "#{Rails.root}/app/assets/images/shoes/ravenna_8.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => brooks_id, :model => model, :color_way => color_way, :forefoot_stack => 18, :heel_stack => 28, :heel_drop => 10, :weight => 10.5, :mileage => 800, :size => 9, :shoe_type => "Stability", :purchased_on => Date.new(2017, 5, 13), :first_used_on => Date.new(2017, 5, 14), retired: true, :retired_on => Date.new(2018, 3, 17),
  :image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Ravenna 9"
color_way = "Neon Yellow/Blue"
image_path = "#{Rails.root}/app/assets/images/shoes/ravenna_9.jpg"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => brooks_id, :model => model, :color_way => color_way, :forefoot_stack => 16, :heel_stack => 26, :heel_drop => 10, :weight => 9.5, :mileage => 700, :size => 9, :shoe_type => "Stability", :purchased_on => Date.new(2018, 3, 17), :first_used_on => Date.new(2018, 3, 18), retired: true, :retired_on => Date.new(2019, 4, 12), 
  :image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Ravenna 10"
color_way = "Blue/Navy/Nightlife"
image_path = "#{Rails.root}/app/assets/images/shoes/ravenna_10.jpeg"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => brooks_id, :model => model, :color_way => color_way, :forefoot_stack => 17, :heel_stack => 27, :heel_drop => 10, :weight => 9.4, :mileage => 239.9, :size => 9, :shoe_type => "Stability", :purchased_on => Date.new(2019, 2, 6), :first_used_on => Date.new(2019, 4, 15), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Wave Rider 22"
color_way = "Blue Jay/Silver"
image_path = "#{Rails.root}/app/assets/images/shoes/waverider_22.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => ShoeBrand.named("Mizuno").id, :model => model, :color_way => color_way, :forefoot_stack => 12, :heel_stack =>32, :heel_drop => 12, :mileage => 14, :weight => 9.6, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 23), :first_used_on => Date.new(2020, 1, 24), retired: true, :retired_on => Date.new(2020, 5, 31), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "880v9"
color_way = "Reflection with Outerspace & RGB Green"
image_path = "#{Rails.root}/app/assets/images/shoes/880v9.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => ShoeBrand.named("New Balance").id, :model => model, :color_way => color_way, :forefoot_stack => 18, :heel_stack => 28, :heel_drop => 10, :mileage => 334.8, :weight => 10.5, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 10, 9), :first_used_on => Date.new(2019, 10, 10), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Vomero 14"
color_way = "Core Black/Cloud White"
image_path = "#{Rails.root}/app/assets/images/shoes/vomero_14.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :forefoot_stack => 17, :heel_stack => 27, :heel_drop => 10, :mileage => 77.8, :weight => 10.7, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 5), :first_used_on => Date.new(2019, 12, 11), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Zoom Fly 3"
color_way = "Black/Light Current Blue/Wolf Grey/White (Chicago Themed)"
image_path = "#{Rails.root}/app/assets/images/shoes/zoom_fly_3_chicago.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :forefoot_stack => 28, :heel_stack => 36, :heel_drop => 8, :mileage => 0, :weight => 8.9, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 1, 8), :retired => true, :retired_on => Date.new(2020, 6, 28), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect
color_way = "Electric Green"
image_path = "#{Rails.root}/app/assets/images/shoes/zoom_fly_3.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :forefoot_stack => 28, :heel_stack => 36, :heel_drop => 8, :mileage => 66.3, :weight => 8.9, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 10, 31), :first_used_on => Date.new(2019, 12, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Vaporfly Next%"
color_way = "Neon Green"
image_path = "#{Rails.root}/app/assets/images/shoes/next%.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :forefoot_stack => 32, :heel_stack => 40, :heel_drop => 8, :mileage => 0, :weight => 6.6, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 10, 22), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "CloudFlow"
color_way = "Rust/Pacific"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudflow.jpeg"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 16, :heel_stack => 22, :heel_drop => 6, :mileage => 141.1, :weight => 8.1, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 10), :first_used_on => Date.new(2019, 12, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "CloudFlow 2.0"
color_way = "Rust/LimeLight"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudflow_2.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 16, :heel_stack => 22, :heel_drop => 6, :mileage => 0, :weight => 7.8, :size => 8, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 21), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Cloudsurfer"
color_way = "Gray/Orange"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudsurfer.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 22, :heel_stack => 29, :heel_drop => 7, :mileage => 16.4, :weight => 10.1, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 1, 29), :first_used_on => Date.new(2020, 1, 31), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Cloudswift (Pair 2)"
color_way = "Sand/Grey"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudswift_sand.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 22, :heel_stack => 29, :heel_drop => 7, :mileage => 6.1, :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 11, 14), :first_used_on => Date.new(2020, 6, 28), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect
model = "Cloudswift"
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 22, :heel_stack => 29, :heel_drop => 7, :mileage => 681.4, :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 4, 1), :first_used_on => Date.new(2019, 8, 18), :retired => true, :retired_on => Date.new(2020, 7, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

color_way = "Rock/Slate"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudswift_rock.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 22, :heel_stack => 29, :heel_drop => 7, :mileage => 38.1, :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 2), :first_used_on => Date.new(2019, 9, 13), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Cloud 2.0"
color_way = "Black/White"
image_path = "#{Rails.root}/app/assets/images/shoes/cloud_2.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 15, :heel_stack => 24, :heel_drop => 9, :mileage => 6.2, :weight => 8.1, :size => 9, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 2, 6), :first_used_on => Date.new(2019, 8, 25), :retired => true, :retired_on => Date.new(2019, 8, 25),
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Kinvara 10"
color_way = "Orange/Black"
image_path = "#{Rails.root}/app/assets/images/shoes/kinvara_10.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :forefoot_stack => 19, :heel_stack => 23, :heel_drop => 4, :weight => 9.4, :mileage => 55.6, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 6, 23), :first_used_on => Date.new(2019, 7, 21), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Triumph 17"
color_way = "Blue/Black"
image_path = "#{Rails.root}/app/assets/images/shoes/triumph_17.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :forefoot_stack => 24, :heel_stack => 32, :heel_drop => 8, :weight => 9.4, :mileage => 142, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 11), :first_used_on => Date.new(2019, 12, 14), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Triumph ISO 4"
color_way = "Black/Slime/Blue"
image_path = "#{Rails.root}/app/assets/images/shoes/triumph_iso_4.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :forefoot_stack => 20, :heel_stack => 28, :heel_drop => 8, :weight => 9.4, :mileage => 0, :size => 8.5, :shoe_type => "Neutral", :purchased_on =>  Date.new(2019, 11, 23), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect
puts ""
puts ""

puts "----------STATES----------"
state_list = Array[ ["AK", "Alaska"], ["AL", "Alabama"], ["AR", "Arkansas"], ["AS", "American Samoa"], ["AZ", "Arizona"], 
                ["CA", "California"], ["CO", "Colorado"], ["CT", "Connecticut"], ["DC", "District of Columbia"], ["DE", "Delaware"], 
                ["FL", "Florida"], ["GA", "Georgia"], ["GU", "Guam"], ["HI", "Hawaii"], ["IA", "Iowa"], ["ID", "Idaho"], 
                ["IL", "Illinois"], ["IN", "Indiana"], ["KS", "Kansas"], ["KY", "Kentucky"], ["LA", "Louisiana"], 
                ["MA", "Massachusetts"], ["MD", "Maryland"], ["ME", "Maine"], ["MI", "Michigan"], ["MN", "Minnesota"], 
                ["MO", "Missouri"], ["MS", "Mississippi"], ["MT", "Montana"], ["NC", "North Carolina"], ["ND", "North Dakota"], 
                ["NE", "Nebraska"], ["NH", "New Hampshire"], ["NJ", "New Jersey"], ["NM", "New Mexico"], ["NV", "Nevada"], 
                ["NY", "New York"], ["OH", "Ohio"], ["OK", "Oklahoma"], ["OR", "Oregon"], ["PA", "Pennsylvania"], 
                ["PR", "Puerto Rico"], ["RI", "Rhode Island"], ["SC", "South Carolina"], ["SD", "South Dakota"], 
                ["TN", "Tennessee"], ["TX", "Texas"], ["UT", "Utah"], ["VA", "Virginia"], ["VI", "Virgin Islands"], 
                ["VT", "Vermont"], ["WA", "Washington"], ["WI", "Wisconsin"], ["WV", "West Virginia"], ["WY", "Wyoming"] ]

state_list.each do |abbr, name|
  State.create_with(abbreviation: abbr, name: name).find_or_create_by(abbreviation: abbr, name: name)
end
puts "SEEDED all 50 States"
puts ""
puts ""


puts "----------MONTH KEYS----------"
month_list = Array[ [1, "January"], [2, "February"], [3, "March"], [4, "April"], [5, "May"], [6, "June"],
                [7, "July"], [8, "August"], [9, "September"], [10, "October"], [11, "November"], [12, "December"] ]

month_list.each do |number, month_name|
  MonthKey.create_with(number: number, name: month_name).find_or_create_by(number: number, name: month_name)
end
puts "SEEDED all 12 Months"
puts ""
puts ""


puts "----------RUN TYPES----------"
type = "Easy Run"
@runtype = RunType.create_with(name: type, hex_code: "#6A0DAD", active: true, default: false).find_or_create_by(name: type)
puts @runtype.inspect

type = "Tempo Run"
@runtype = RunType.create_with(name: type, hex_code: "#228B22", active: true, default: false).find_or_create_by(name: type)
puts @runtype.inspect

type = "Speed Run"
@runtype = RunType.create_with(name: type, hex_code: "#1E90FF", active: true, default: false).find_or_create_by(name: type)
puts @runtype.inspect

type = "Long Run"
@runtype = RunType.create_with(name: type, hex_code: "#FFD700", active: true, default: false).find_or_create_by(name: type)
puts @runtype.inspect

type = "Race"
@runtype = RunType.create_with(name: type, hex_code: "#FF0000", active: true, default: false).find_or_create_by(name: type)
puts @runtype.inspect

type = "Recreational Run"
@runtype = RunType.create_with(name: type, hex_code: "#FF6347", active: true, default: true).find_or_create_by(name: type)
puts @runtype.inspect
puts ""
puts ""


puts "----------OBLIGATIONS----------"
@obligation = Obligation.find_or_create_by(name: "Kendo", start_datetime: DateTime.new(2020, 9, 29, 20, 0, 0), end_datetime: DateTime.new(2020, 9, 29, 22, 0, 0), city: "Los Angeles", :state_id => State.find_by_abbr("CA").id)
puts @obligation.inspect
@obligation = Obligation.find_or_create_by(name: "Jeff's Wedding", start_datetime: DateTime.new(2020, 9, 5, 16, 30, 0), end_datetime: DateTime.new(2020, 9, 5, 23, 0, 0), city: "Chicago", :state_id => State.find_by_abbr("IL").id)
puts @obligation.inspect
@obligation = Obligation.find_or_create_by(name: "Meeting", start_datetime: DateTime.new(2020, 9, 16, 10, 15, 30), end_datetime: DateTime.new(2020, 9, 16, 10, 45, 0), city: "Seattle", :state_id => State.find_by_abbr("WA").id)
puts @obligation.inspect
puts ""
puts ""


user_id = User.find_user_by_name("Peter", "Schorsch").id
puts "----------ALL TIME TOTALS----------"
@alltime = AllTimeTotal.find_or_create_by(mileage_total: BigDecimal('2209'), elevation_gain: 69153, number_of_runs: 315, hours: 263, minutes: 42, seconds: 0, user_id: user_id)
puts @alltime.inspect
puts ""
puts ""


#puts "----------MONTHLY TOTALS----------"
#YearlyTotal.all.each do |yearly_total|
#  @first_month_of_year = yearly_total.year_start.at_beginning_of_year.beginning_of_month
#  @last_month_of_year = yearly_total.year_end.end_of_year.end_of_month
#  year = yearly_total.year_end.year

#  (@first_month_of_year.month...@last_month_of_year.month+1).each do |month|
    #month_end = DateTime.new(year, month, Time.days_in_month(month, year), 23, 59, 59, DateTime.now.zone)
    #month_start = month_end.beginning_of_month
#    @monthly_total = MonthlyTotal.find_or_create_by(month_number: month, month_year: year, mileage_total: 200, elevation_gain: 10000, number_of_runs: 24, hours: 30, minutes: 26, seconds: 52, user_id: user_id, yearly_total_id: yearly_total.id)
#    puts @monthly_total.inspect

#    puts "----------WEEKLY TOTALS----------"
    #(1..month_end.total_weeks).each do |week_number_of_month|
#    (1..52).each do |week_number|
      #week_end = DateTime.new(year, month_end.month, Time.days_in_month(month, year), 23, 59, 59, DateTime.now.zone)+week_number_of_month.week
#      @weekly_total = WeeklyTotal.find_or_create_by(week_number: week_number, week_month: month, mileage_total: 35, goal: 40, met_goal: true, hours: 5, minutes: 24, seconds: 05, number_of_runs: 6, elevation_gain: 670, user_id: user_id, monthly_total_id: @monthly_total.id)
      #puts @weekly_total.inspect
#    end

#  end
#  puts ""
#end
#puts ""

puts "----------RUNS----------"
run_type_id = RunType.named("Race").id
illinois_state_id = State.find_by_abbr("IL").id

puts "----------2017----------"
run_date = DateTime.new(2017, 7, 8, 8, 0, 0)
@run = Run.find_or_create_by(name: "Chicago Chinatown 5K & Youth Run", planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "19", seconds: "59", pace: "6:26", gear_id: Gear.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('0'), city: "Chicago", state_id: illinois_state_id, notes: "Bib #: 438", run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2017, 7, 15, 6, 30, 0)
@run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "33", seconds: "09", pace: "7:27", notes: "Bib#: 1386", city: "Chicago", gear_id: Gear.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('150'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2017, 9, 17, 7, 0, 0)
@run = Run.find_or_create_by(name: "Fox Valley Marathon", planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "3", minutes: "11", seconds: "17", pace: "7:18", notes: "Bib#: 727", city: "St. Charles", gear_id: Gear.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('326'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2017, 10, 22, 7, 0, 0)
@run = Run.find_or_create_by(name: "Naperville Half Marathon and 5K", planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "25", seconds: "48", pace: "6:33", notes: "Bib#: 3800", city: "Naperville", gear_id: Gear.find_shoe("Ravenna 8").id, elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

puts "----------2018----------"
run_date = DateTime.new(2018, 5, 20, 7, 50, 0)
@run = Run.find_or_create_by(name: "Chicago Spring Half Marathon & 10k", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "38", seconds: "21", pace: "6:11", notes: "Bib#: 8111", city: "Chicago", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('6.2'), mileage_total: BigDecimal('6.2'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, personal_best: true, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2018, 7, 14, 8, 0, 0)
@run = Run.find_or_create_by(name: "Chicago Chinatown 5K & Youth Run", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "18", seconds: "04", pace: "5:49", notes: "Bib#: 36", city: "Chicago", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2018, 7, 21, 6, 30, 0)
@run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "21", seconds: "18", pace: "6:12", notes: "Bib#: 1346", city: "Chicago", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2018, 9, 16, 7, 0, 0)
@run = Run.find_or_create_by(name: "Fox Valley Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "51", seconds: "48", pace: "6:33", notes: "Bib#:  622", city: "St. Charles", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('326'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2018, 10, 7, 7, 30, 0)
@run = Run.find_or_create_by(name: "Bank of America Chicago Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "46", seconds: "11", pace: "6:21", notes: "Bib#: 6084", city: "Chicago", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('242'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2018, 10, 21, 7, 0, 0)
@run = Run.find_or_create_by(name: "Naperville Half Marathon and 5K", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "19", seconds: "57", pace: "6:07", notes: "Bib#: 1473", city: "Naperville", gear_id: Gear.find_shoe("Ravenna 9").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

puts "----------2019----------"
run_date = DateTime.new(2019, 4, 15, 10, 02, 0)
@run = Run.find_or_create_by(name: "Boston Marathon", start_time: run_date.in_time_zone("Eastern Time (US & Canada)"), hours: "2", minutes: "57", seconds: "08", pace: "6:46", notes: "Bib#: 1183", city: "Boston", gear_id: Gear.find_shoe("Ravenna 10").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('655'), state_id: State.find_by_abbr("MA").id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2019, 7, 21, 6, 30, 0)
@run = Run.find_or_create_by(name: "Rock 'n' Roll Chicago Half Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "1", minutes: "19", seconds: "44", pace: "6:05", notes: "Bib#: 1175", city: "Chicago", gear_id: Gear.find_shoe("Kinvara 10").id, planned_mileage: BigDecimal('13.1'), mileage_total: BigDecimal('13.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, personal_best: true, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2019, 9, 22, 7, 0, 0)
@run = Run.find_or_create_by(name: "Fox Valley Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "49", seconds: "34", pace: "6:28", notes: "Bib#: 347", city: "St. Charles", gear_id: Gear.find_shoe("Kinvara 10").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('326'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2019, 10, 6, 8, 30, 0)
@run = Run.find_or_create_by(name: "Bucktown 5K Run", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "0", minutes: "18", seconds: "4", pace: "5:49", city: "Chicago", notes: "Bib#: 4291", gear_id: Gear.find_shoe("Adios 4").id, planned_mileage: BigDecimal('3.1'), mileage_total: BigDecimal('3.1'), elevation_gain: BigDecimal('0'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, personal_best: true, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2019, 10, 13, 7, 30, 0)
@run = Run.find_or_create_by(name: "Bank of America Chicago Marathon", start_time: run_date.in_time_zone("Central Time (US & Canada)"), hours: "2", minutes: "43", seconds: "08", pace: "6:14", notes: "Bib#: 11184", city: "Chicago", gear_id: Gear.find_shoe("Adios 4").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('100'), state_id: illinois_state_id, run_type_id: run_type_id, user_id: user_id, personal_best: true, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2019, 11, 3, 9, 42, 0)
@run = Run.find_or_create_by(name: "TCS New York City Marathon", start_time: run_date.in_time_zone("Eastern Time (US & Canada)"), hours: "3", minutes: "7", seconds: "16", pace: "7:09", notes: "Bib#: 2052", city: "New York", gear_id: Gear.find_shoe_with_color("Cloudswift", "Rock/Slate").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('830'), state_id: State.find_by_abbr("NY").id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

puts "----------2020----------"
run_date = DateTime.new(2020, 3, 8, 6, 55, 0)
@run = Run.find_or_create_by(name: "Los Angeles Marathon", start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), hours: "2", minutes: "48", seconds: "35", pace: "6:26", notes: "Bib#: 1356", city: "Los Angeles", gear_id: Gear.find_shoe("Adios 4").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('850'), state_id: State.find_by_abbr("CA").id, run_type_id: run_type_id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2020, 9, 5, 10, 0, 0)
@run = Run.find_or_create_by(name: "Testing", start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), hours: "2", minutes: "48", seconds: "35", pace: "6:26", notes: "Bib#: 1356", city: "Los Angeles", gear_id: Gear.find_shoe("Adios 4").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('850'), state_id: State.find_by_abbr("CA").id, run_type_id: RunType.named("Long Run").id, user_id: user_id, completed_run: true)
puts @run.inspect

run_date = DateTime.new(2020, 9, 8, 18, 15, 0)
@run = Run.find_or_create_by(name: "Testing 2", start_time: run_date.in_time_zone("Pacific Time (US & Canada)"), hours: "2", minutes: "48", seconds: "35", pace: "6:26", notes: "Bib#: 1356", city: "Los Angeles", gear_id: Gear.find_shoe("Adios 4").id, planned_mileage: BigDecimal('26.2'), mileage_total: BigDecimal('26.2'), elevation_gain: BigDecimal('850'), state_id: State.find_by_abbr("CA").id, run_type_id: RunType.named("Easy Run").id, user_id: user_id, completed_run: true)
puts @run.inspect
puts ""
puts ""

puts "----------YEARLY TOTALS----------"
@yearly_2017 = YearlyTotal.find_or_create_by(year: "2017", year_start: DateTime.new(2017).beginning_of_year.in_time_zone("Pacific Time (US & Canada)"), year_end: DateTime.new(2017).end_of_year.in_time_zone("Pacific Time (US & Canada)"), mileage_total: BigDecimal('750.8'), elevation_gain: 7000, number_of_runs: 150, hours: 90, minutes: 2, seconds: 29, user_id: user_id, all_time_total_id: @my_admin_user.all_time_total.id)
puts @yearly_2017.inspect
@yearly_2018 = YearlyTotal.find_or_create_by(year: "2018", year_start: DateTime.new(2018).beginning_of_year.in_time_zone("Pacific Time (US & Canada)"), year_end: DateTime.new(2018).end_of_year.in_time_zone("Pacific Time (US & Canada)"), mileage_total: BigDecimal('800'), elevation_gain: 10000, number_of_runs: 150, hours: 100, minutes: 30, seconds: 57, user_id: user_id, all_time_total_id: @my_admin_user.all_time_total.id)
puts @yearly_2018.inspect
@yearly_2019 = YearlyTotal.find_or_create_by(year: "2019", year_start: DateTime.new(2019).beginning_of_year.in_time_zone("Pacific Time (US & Canada)"), year_end: DateTime.new(2019).end_of_year.in_time_zone("Pacific Time (US & Canada)"), mileage_total: BigDecimal('664.7'), elevation_gain: 14327, number_of_runs: 101, hours: 73, minutes: 6, seconds: 0, user_id: user_id, all_time_total_id: @my_admin_user.all_time_total.id)
puts @yearly_2019.inspect
@yearly_2020 = YearlyTotal.find_or_create_by(year: "2020", year_start: DateTime.new(2020).beginning_of_year.in_time_zone("Pacific Time (US & Canada)"), year_end: DateTime.new(2020).end_of_year.in_time_zone("Pacific Time (US & Canada)"), mileage_total: BigDecimal('1564'), elevation_gain: 54826, number_of_runs: 214, hours: 190, minutes: 36, seconds: 0, user_id: user_id, all_time_total_id: @my_admin_user.all_time_total.id)
puts @yearly_2020.inspect
puts ""
puts ""


puts "----------CREATE DEFAULT RUNS FOR CURRENT WEEK----------"
puts Run.create_weeklong_default_runs(@my_admin_user)
puts ""
puts ""

puts "RAN SEEDING IN " + (Time.now - start).round(1).to_s + " SECONDS"
