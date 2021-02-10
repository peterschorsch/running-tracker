@my_admin_user = User.find_user_by_name("Peter","Schorsch")

puts "----------SHOW BRANDS----------"
shoe_brands = ["Adidas", "Altra", "ASICS", "Atreyu", "Brooks", "DEFAULT", "Hoka One One", "Mizuno", "Newton", "New Balance", "Nike", "ON", "Saloman", "Saucony"]
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
on_id = ShoeBrand.named("ON").id
saucony_id = ShoeBrand.named("Saucony").id

model = "RUNNING SHOE"
color_way = "White"
image_path = "#{Rails.root}/app/assets/images/shoes/stock_shoe.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => ShoeBrand.named("DEFAULT").id, :model => model, :color_way => color_way, :forefoot_stack => 0, :heel_stack => 0, :heel_drop => "0", :weight => 0, :size => "0", :shoe_type => "Neutral", :default => true, :purchased_on => Date.current, :first_used_on => Date.current,
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Adios 4"
color_way = "Core Black/Cloud White"
image_path = "#{Rails.root}/app/assets/images/shoes/adios_4.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => adidias_id, :model => model, :color_way => color_way, :forefoot_stack => 17, :heel_stack => 27, :heel_drop => 10, :previous_mileage => BigDecimal('87.1'), :mileage_total => BigDecimal('87.1'), :weight => 9.4, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 8, 12), :first_used_on => Date.new(2019, 10, 6),
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect


model = "Escalante 2"
color_way = "Gray"
image_path = "#{Rails.root}/app/assets/images/shoes/escalante_2.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => alta_id, :model => model, :color_way => color_way, :heel_drop => 0, :previous_mileage => BigDecimal('259.6'), :mileage_total => BigDecimal('259.6'), :weight => 9.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 23), :first_used_on => Date.new(2019, 9, 25), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Ravenna 8"
color_way = "Red/White"
image_path = "#{Rails.root}/app/assets/images/shoes/ravenna_8.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => brooks_id, :model => model, :color_way => color_way, :forefoot_stack => 18, :heel_stack => 28, :heel_drop => 10, :weight => 10.5, :previous_mileage => BigDecimal('800'), :mileage_total => BigDecimal('800'), :size => 9, :shoe_type => "Stability", :purchased_on => Date.new(2017, 5, 13), :first_used_on => Date.new(2017, 5, 14), retired: true, :retired_on => Date.new(2018, 3, 17),
  :image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Ravenna 9"
color_way = "Neon Yellow/Blue"
image_path = "#{Rails.root}/app/assets/images/shoes/ravenna_9.jpg"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => brooks_id, :model => model, :color_way => color_way, :forefoot_stack => 16, :heel_stack => 26, :heel_drop => 10, :weight => 9.5, :previous_mileage => BigDecimal('800'), :mileage_total => BigDecimal('800'), :size => 9, :shoe_type => "Stability", :purchased_on => Date.new(2018, 3, 17), :first_used_on => Date.new(2018, 3, 18), retired: true, :retired_on => Date.new(2019, 4, 12), 
  :image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Ravenna 10"
color_way = "Blue/Navy/Nightlife"
image_path = "#{Rails.root}/app/assets/images/shoes/ravenna_10.jpeg"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => brooks_id, :model => model, :color_way => color_way, :forefoot_stack => 17, :heel_stack => 27, :heel_drop => 10, :weight => 9.4, :previous_mileage => BigDecimal('683.1'), :mileage_total => BigDecimal('683.1'), :size => 9, :shoe_type => "Stability", :purchased_on => Date.new(2019, 2, 6), :first_used_on => Date.new(2019, 4, 15), retired: true, :retired_on => Date.new(2020, 11, 28), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Wave Rider 15"
color_way = "Blue/White"
image_path = "#{Rails.root}/app/assets/images/shoes/waverider_15.jpg"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => ShoeBrand.named("Mizuno").id, :model => model, :color_way => color_way, :forefoot_stack => 12, :heel_stack =>32, :heel_drop => 12, :previous_mileage => BigDecimal('6.2'), :mileage_total => BigDecimal('6.2'), :weight => 9.6, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2013, 2, 23), :first_used_on => Date.new(2013, 2, 25), retired: true, :retired_on => Date.new(2015, 11, 30), 
  :image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Wave Rider 22"
color_way = "Blue Jay/Silver"
image_path = "#{Rails.root}/app/assets/images/shoes/waverider_22.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => ShoeBrand.named("Mizuno").id, :model => model, :color_way => color_way, :forefoot_stack => 12, :heel_stack =>32, :heel_drop => 12, :previous_mileage => BigDecimal('14'), :mileage_total => BigDecimal('14'), :weight => 9.6, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 23), :first_used_on => Date.new(2020, 1, 24), retired: true, :retired_on => Date.new(2020, 5, 31), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "880v9"
color_way = "Reflection with Outerspace & RGB Green"
image_path = "#{Rails.root}/app/assets/images/shoes/880v9.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => ShoeBrand.named("New Balance").id, :model => model, :color_way => color_way, :forefoot_stack => 18, :heel_stack => 28, :heel_drop => 10, :previous_mileage => BigDecimal('461'), :mileage_total => BigDecimal('461'), :weight => 10.5, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 10, 9), :first_used_on => Date.new(2019, 10, 10), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Vomero 14"
color_way = "Core Black/Cloud White"
image_path = "#{Rails.root}/app/assets/images/shoes/vomero_14.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :forefoot_stack => 17, :heel_stack => 27, :heel_drop => 10, :previous_mileage => BigDecimal('77.8'), :mileage_total => BigDecimal('77.8'), :weight => 10.7, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 5), :first_used_on => Date.new(2019, 12, 11), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Zoom Fly 3"
color_way = "Electric Green"
image_path = "#{Rails.root}/app/assets/images/shoes/zoom_fly_3.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :forefoot_stack => 28, :heel_stack => 36, :heel_drop => 8, :previous_mileage => BigDecimal('79.5'), :mileage_total => BigDecimal('79.5'), :weight => 8.9, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 10, 31), :first_used_on => Date.new(2019, 12, 12), :retired => true, :retired_on => Date.new(2020, 11, 16),
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "CloudFlow"
color_way = "Rust/Pacific"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudflow.jpeg"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 16, :heel_stack => 22, :heel_drop => 6, :previous_mileage => BigDecimal('141.2'), :mileage_total => BigDecimal('141.2'), :weight => 8.1, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 10), :first_used_on => Date.new(2019, 12, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Cloudswift"
color_way = "Sand/Grey"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudswift_sand.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 22, :heel_stack => 29, :heel_drop => 7, :previous_mileage => BigDecimal('716.3'), :mileage_total => BigDecimal('716.3'), :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 4, 1), :first_used_on => Date.new(2019, 8, 18), :retired => true, :retired_on => Date.new(2020, 7, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

color_way = "Rock/Slate"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudswift_rock.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 22, :heel_stack => 29, :heel_drop => 7, :previous_mileage => BigDecimal('39.3'), :mileage_total => BigDecimal('39.3'), :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 2), :first_used_on => Date.new(2019, 9, 13), :retired => true, :retired_on => Date.new(2020, 11, 21),
  :image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Cloud 2.0"
color_way = "Black/White"
image_path = "#{Rails.root}/app/assets/images/shoes/cloud_2.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 15, :heel_stack => 24, :heel_drop => 9, :previous_mileage => BigDecimal('6.2'), :mileage_total => BigDecimal('6.2'), :weight => 8.1, :size => 9, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 2, 6), :first_used_on => Date.new(2019, 8, 25), :retired => true, :retired_on => Date.new(2019, 8, 25),
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Kinvara 10"
color_way = "Orange/Black"
image_path = "#{Rails.root}/app/assets/images/shoes/kinvara_10.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :forefoot_stack => 19, :heel_stack => 23, :heel_drop => 4, :weight => 9.4, :previous_mileage => BigDecimal('55.6'), :mileage_total => BigDecimal('55.6'), :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 6, 23), :first_used_on => Date.new(2019, 7, 21), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Triumph 17"
color_way = "Blue/Black"
image_path = "#{Rails.root}/app/assets/images/shoes/triumph_17.png"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :forefoot_stack => 24, :heel_stack => 32, :heel_drop => 8, :weight => 9.4, :previous_mileage => BigDecimal('142'), :mileage_total => BigDecimal('142'), :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 11), :first_used_on => Date.new(2019, 12, 14), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect

model = "Voyager"
color_way = "Blue/White"
image_path = "#{Rails.root}/app/assets/images/shoes/voyager.jpg"
image_file = File.new(image_path)
@shoe = Shoe.create_with(:shoe_brand_id => ShoeBrand.named("Atreyu").id, :model => model, :color_way => color_way, :forefoot_stack => 15.5, :heel_stack => 21.5, :heel_drop => 6, :weight => 6, :previous_mileage => 25.8, :size => 8.5, :shoe_type => "Neutral", :purchased_on =>  Date.new(2020, 12, 1), :first_used_on => Date.new(2020, 12, 23),
  :image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @my_admin_user.id)
puts @shoe.inspect
puts ""
puts ""