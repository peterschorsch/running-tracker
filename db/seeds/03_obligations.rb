puts "----------OBLIGATIONS----------"
@my_admin_user = User.find_user_by_name("Peter","Schorsch")
@website_viewer = User.return_website_viewer

@obligation_color = ObligationColor.find_or_create_by(name: "Default Color - Black", hex_code: "#17202A")
puts @obligation_color.inspect


### TESTING FOR MYSELF - TEMPORARY ###
@obligation = Obligation.find_or_create_by(name: "Kendo Class", start_time: DateTime.now-5.days, end_time: DateTime.now-5.days, city: "Los Angeles", state_id: State.find_by_abbr("CA").id, user_id: @my_admin_user.id, obligation_color_id: @obligation_color.id)
puts @obligation.inspect
@obligation = Obligation.find_or_create_by(name: "Cousin's Wedding", start_time: DateTime.now-4.days, end_time: nil, city: "Chicago", state_id: State.find_by_abbr("IL").id, user_id: @my_admin_user.id, obligation_color_id: @obligation_color.id)
puts @obligation.inspect
@obligation = Obligation.find_or_create_by(name: "Attend Meeting", start_time: DateTime.now-1.hour, end_time: DateTime.now, city: "Los Angeles", state_id: State.find_by_abbr("CA").id, user_id: @my_admin_user.id, obligation_color_id: @obligation_color.id)
puts @obligation.inspect
puts ""
puts ""