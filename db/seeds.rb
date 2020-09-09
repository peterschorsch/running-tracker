start = Time.now
puts "---------------STARTED SEEDING---------------"
puts ""

puts "----------ADMINS----------"
@admin_user = User.create_with(first_name: "Peter", last_name: "Schorsch", active: true, password_digest: User.digest("Peteschorsch1!"), role: "Admin").find_or_create_by(email: "peteschorsch@gmail.com")
puts @admin_user.inspect
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
nike_id = ShoeBrand.named("Nike").id
on_id = ShoeBrand.named("On").id
saucony_id = ShoeBrand.named("Saucony").id

model = "RUNNING SHOE"
color_way = "White"
image_path = "#{Rails.root}/app/assets/images/shoes/stock_shoe.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => ShoeBrand.named("DEFAULT").id, :model => model, :color_way => color_way, :heel_drop => 0, :mileage => 0, :weight => 0, :size => 8.5, :shoe_type => "Neutral", :default => true, :purchased_on => Date.today, :first_used_on => Date.today,
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Adios 4"
color_way = "Core Black/Cloud White"
image_path = "#{Rails.root}/app/assets/images/shoes/adios_4.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => adidias_id, :model => model, :color_way => color_way, :heel_drop => 10, :mileage => 87.1, :weight => 9.4, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 8, 12), :first_used_on => Date.new(2019, 10, 6),
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect
model = "Adios 4 (Pair 2)"
@gear = Gear.create_with(:shoe_brand_id => adidias_id, :model => model, :color_way => color_way, :heel_drop => 10, :weight => 9.4, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 3, 15), 
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

model = "Ravenna 10"
color_way = "Blue/Navy/Nightlife"
image_path = "#{Rails.root}/app/assets/images/shoes/ravenna_10.jpeg"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => ShoeBrand.named("Brooks").id, :model => model, :color_way => color_way, :heel_drop => 10, :weight => 9.4, :mileage => 239.9, :size => 9, :shoe_type => "Stability", :purchased_on => Date.new(2019, 2, 6), :first_used_on => Date.new(2019, 4, 15), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Waverider 22"
color_way = "Blue Jay/Silver"
image_path = "#{Rails.root}/app/assets/images/shoes/waverider_22.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => ShoeBrand.named("Mizuno").id, :model => model, :color_way => color_way, :heel_drop => 12, :mileage => 14, :weight => 9.6, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 23), :first_used_on => Date.new(2020, 1, 24), retired: true, :retired_on => Date.new(2020, 5, 31), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "880v9"
color_way = "Reflection with Outerspace & RGB Green"
image_path = "#{Rails.root}/app/assets/images/shoes/880v9.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => ShoeBrand.named("New Balance").id, :model => model, :color_way => color_way, :heel_drop => 10, :mileage => 334.8, :weight => 10.5, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 10, 9), :first_used_on => Date.new(2019, 10, 10), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Vomero 14"
color_way = "Core Black/Cloud White"
image_path = "#{Rails.root}/app/assets/images/shoes/vomero_14.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :heel_drop => 10, :mileage => 77.8, :weight => 10.7, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 5), :first_used_on => Date.new(2019, 12, 11), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Zoom Fly 3"
color_way = "Black/Light Current Blue/Wolf Grey/White (Chicago Themed)"
image_path = "#{Rails.root}/app/assets/images/shoes/zoom_fly_3_chicago.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :heel_drop => 8, :mileage => 0, :weight => 8.9, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 1, 8), :retired => true, :retired_on => Date.new(2020, 6, 28), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect
color_way = "Electric Green"
image_path = "#{Rails.root}/app/assets/images/shoes/zoom_fly_3.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :heel_drop => 8, :mileage => 66.3, :weight => 8.9, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 10, 31), :first_used_on => Date.new(2019, 12, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Vaporfly Next%"
color_way = "Neon Green"
image_path = "#{Rails.root}/app/assets/images/shoes/next%.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :heel_drop => 8, :mileage => 0, :weight => 6.6, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 10, 22), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "CloudFlow"
color_way = "Rust/Pacific"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudflow.jpeg"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :heel_drop => 6, :mileage => 141.1, :weight => 8.1, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 10), :first_used_on => Date.new(2019, 12, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "CloudFlow 2.0"
color_way = "Rust/LimeLight"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudflow_2.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :heel_drop => 6, :mileage => 0, :weight => 7.8, :size => 8, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 21), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Cloudsurfer"
color_way = "Gray/Orange"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudsurfer.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :heel_drop => 7, :mileage => 16.4, :weight => 10.1, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 1, 29), :first_used_on => Date.new(2020, 1, 31), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Cloudswift (Pair 2)"
color_way = "Sand/Grey"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudswift_sand.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :heel_drop => 7, :mileage => 6.1, :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 11, 14), :first_used_on => Date.new(2020, 6, 28), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect
model = "Cloudswift"
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :heel_drop => 7, :mileage => 681.4, :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 4, 1), :first_used_on => Date.new(2019, 8, 18), :retired => true, :retired_on => Date.new(2020, 7, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

color_way = "Rock/Slate"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudswift_rock.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :heel_drop => 7, :mileage => 38.1, :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 2), :first_used_on => Date.new(2019, 9, 13), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Cloud 2.0"
color_way = "Black/White"
image_path = "#{Rails.root}/app/assets/images/shoes/cloud_2.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :heel_drop => 6, :mileage => 6.2, :weight => 8.1, :size => 9, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 2, 6), :first_used_on => Date.new(2019, 8, 25), :retired => true, :retired_on => Date.new(2019, 8, 25),
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Kinvara 10"
color_way = "Orange/Black"
image_path = "#{Rails.root}/app/assets/images/shoes/kinvara_10.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :heel_drop => 4, :weight => 9.4, :mileage => 55.6, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 6, 23), :first_used_on => Date.new(2019, 7, 21), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Triumph 17"
color_way = "Blue/Black"
image_path = "#{Rails.root}/app/assets/images/shoes/triumph_17.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :heel_drop => 8, :weight => 9.4, :mileage => 142, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 11), :first_used_on => Date.new(2019, 12, 14), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way)
puts @gear.inspect

model = "Triumph ISO 4"
color_way = "Black/Slime/Blue"
image_path = "#{Rails.root}/app/assets/images/shoes/triumph_iso_4.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :heel_drop => 8, :weight => 9.4, :mileage => 0, :size => 8.5, :shoe_type => "Neutral", :purchased_on =>  Date.new(2019, 11, 23), 
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


puts "RAN SEEDING IN " + (Time.now - start).round(1).to_s + " SECONDS"
