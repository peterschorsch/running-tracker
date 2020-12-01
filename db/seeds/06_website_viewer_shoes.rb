@website_viewer = User.return_website_viewer

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
@gear = Gear.create_with(:shoe_brand_id => ShoeBrand.named("DEFAULT").id, :model => model, :color_way => color_way, :forefoot_stack => 0, :heel_stack => 0, :heel_drop => 0, :mileage => 0, :weight => 0, :size => 8.5, :shoe_type => "Neutral", :default => false, :purchased_on => Date.today, :first_used_on => Date.today,
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Adios 4"
color_way = "Core Black/Cloud White"
image_path = "#{Rails.root}/app/assets/images/shoes/adios_4.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:default => true, :shoe_brand_id => adidias_id, :model => model, :color_way => color_way, :forefoot_stack => 17, :heel_stack => 27, :heel_drop => 10, :mileage => 107.9, :weight => 9.4, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 8, 12), :first_used_on => Date.new(2019, 10, 6),
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Escalante 2"
color_way = "Gray"
image_path = "#{Rails.root}/app/assets/images/shoes/escalante_2.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => alta_id, :model => model, :color_way => color_way, :heel_drop => 0, :mileage => 259.7, :weight => 9.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 23), :first_used_on => Date.new(2019, 9, 25), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Ravenna 8"
color_way = "Red/White"
image_path = "#{Rails.root}/app/assets/images/shoes/ravenna_8.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => brooks_id, :model => model, :color_way => color_way, :forefoot_stack => 18, :heel_stack => 28, :heel_drop => 10, :weight => 10.5, :mileage => 800, :size => 9, :shoe_type => "Stability", :purchased_on => Date.new(2017, 5, 13), :first_used_on => Date.new(2017, 5, 14), retired: true, :retired_on => Date.new(2018, 3, 17),
  :image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Ravenna 9"
color_way = "Neon Yellow/Blue"
image_path = "#{Rails.root}/app/assets/images/shoes/ravenna_9.jpg"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => brooks_id, :model => model, :color_way => color_way, :forefoot_stack => 16, :heel_stack => 26, :heel_drop => 10, :weight => 9.5, :mileage => 700, :size => 9, :shoe_type => "Stability", :purchased_on => Date.new(2018, 3, 17), :first_used_on => Date.new(2018, 3, 18), retired: true, :retired_on => Date.new(2019, 4, 12), 
  :image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Ravenna 10"
color_way = "Blue/Navy/Nightlife"
image_path = "#{Rails.root}/app/assets/images/shoes/ravenna_10.jpeg"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => brooks_id, :model => model, :color_way => color_way, :forefoot_stack => 17, :heel_stack => 27, :heel_drop => 10, :weight => 9.4, :mileage => 239.9, :size => 9, :shoe_type => "Stability", :purchased_on => Date.new(2019, 2, 6), :first_used_on => Date.new(2019, 4, 15), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Wave Rider 22"
color_way = "Blue Jay/Silver"
image_path = "#{Rails.root}/app/assets/images/shoes/waverider_22.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => ShoeBrand.named("Mizuno").id, :model => model, :color_way => color_way, :forefoot_stack => 12, :heel_stack =>32, :heel_drop => 12, :mileage => 14, :weight => 9.6, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 23), :first_used_on => Date.new(2020, 1, 24), retired: true, :retired_on => Date.new(2020, 5, 31), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "880v9"
color_way = "Reflection with Outerspace & RGB Green"
image_path = "#{Rails.root}/app/assets/images/shoes/880v9.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => ShoeBrand.named("New Balance").id, :model => model, :color_way => color_way, :forefoot_stack => 18, :heel_stack => 28, :heel_drop => 10, :mileage => 334.8, :weight => 10.5, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 10, 9), :first_used_on => Date.new(2019, 10, 10), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Vomero 14"
color_way = "Core Black/Cloud White"
image_path = "#{Rails.root}/app/assets/images/shoes/vomero_14.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :forefoot_stack => 17, :heel_stack => 27, :heel_drop => 10, :mileage => 77.8, :weight => 10.7, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 5), :first_used_on => Date.new(2019, 12, 11), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Zoom Fly 3"
color_way = "Electric Green"
image_path = "#{Rails.root}/app/assets/images/shoes/zoom_fly_3.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => nike_id, :model => model, :color_way => color_way, :forefoot_stack => 28, :heel_stack => 36, :heel_drop => 8, :mileage => 66.3, :weight => 8.9, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 10, 31), :first_used_on => Date.new(2019, 12, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "CloudFlow"
color_way = "Rust/Pacific"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudflow.jpeg"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 16, :heel_stack => 22, :heel_drop => 6, :mileage => 141.1, :weight => 8.1, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 10), :first_used_on => Date.new(2019, 12, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "CloudFlow 2.0"
color_way = "Rust/LimeLight"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudflow_2.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 16, :heel_stack => 22, :heel_drop => 6, :mileage => 0, :weight => 7.8, :size => 8, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 21), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Cloudsurfer"
color_way = "Gray/Orange"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudsurfer.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 22, :heel_stack => 29, :heel_drop => 7, :mileage => 16.4, :weight => 10.1, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 1, 29), :first_used_on => Date.new(2020, 1, 31), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Cloudswift (Pair 2)"
color_way = "Sand/Grey"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudswift_sand.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 22, :heel_stack => 29, :heel_drop => 7, :mileage => 6.1, :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2020, 11, 14), :first_used_on => Date.new(2020, 6, 28), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect
model = "Cloudswift"
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 22, :heel_stack => 29, :heel_drop => 7, :mileage => 681.4, :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 4, 1), :first_used_on => Date.new(2019, 8, 18), :retired => true, :retired_on => Date.new(2020, 7, 12), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

color_way = "Rock/Slate"
image_path = "#{Rails.root}/app/assets/images/shoes/cloudswift_rock.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 22, :heel_stack => 29, :heel_drop => 7, :mileage => 38.1, :weight => 10.2, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 9, 2), :first_used_on => Date.new(2019, 9, 13), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Cloud 2.0"
color_way = "Black/White"
image_path = "#{Rails.root}/app/assets/images/shoes/cloud_2.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => on_id, :model => model, :color_way => color_way, :forefoot_stack => 15, :heel_stack => 24, :heel_drop => 9, :mileage => 6.2, :weight => 8.1, :size => 9, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 2, 6), :first_used_on => Date.new(2019, 8, 25), :retired => true, :retired_on => Date.new(2019, 8, 25),
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Kinvara 10"
color_way = "Orange/Black"
image_path = "#{Rails.root}/app/assets/images/shoes/kinvara_10.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :forefoot_stack => 19, :heel_stack => 23, :heel_drop => 4, :weight => 9.4, :mileage => 55.6, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 6, 23), :first_used_on => Date.new(2019, 7, 21), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Triumph 17"
color_way = "Blue/Black"
image_path = "#{Rails.root}/app/assets/images/shoes/triumph_17.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :forefoot_stack => 24, :heel_stack => 32, :heel_drop => 8, :weight => 9.4, :mileage => 142, :size => 8.5, :shoe_type => "Neutral", :purchased_on => Date.new(2019, 11, 11), :first_used_on => Date.new(2019, 12, 14), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect

model = "Triumph ISO 4"
color_way = "Black/Slime/Blue"
image_path = "#{Rails.root}/app/assets/images/shoes/triumph_iso_4.png"
image_file = File.new(image_path)
@gear = Gear.create_with(:shoe_brand_id => saucony_id, :model => model, :color_way => color_way, :forefoot_stack => 20, :heel_stack => 28, :heel_drop => 8, :weight => 9.4, :mileage => 0, :size => 8.5, :shoe_type => "Neutral", :purchased_on =>  Date.new(2019, 11, 23), 
	:image => ActionDispatch::Http::UploadedFile.new(:filename => File.basename(image_file),:tempfile => image_file,
    # detect the image's mime type with MIME if you can't provide it yourself.
    :type => MIME::Types.type_for(image_path).first.content_type
  )).find_or_create_by(:model => model, :color_way => color_way, :user_id => @website_viewer.id)
puts @gear.inspect
puts ""
puts ""