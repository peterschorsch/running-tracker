puts "----------OBLIGATIONS----------"
@my_admin_user = User.find_user_by_name("Peter","Schorsch")
@website_viewer = User.return_website_viewer

@obligation_color = ObligationColor.find_or_create_by(name: "Default Color - Black", hex_code: "#17202A")
puts @obligation_color.inspect


### TESTING FOR MYSELF - TEMPORARY ###
@obligations = @my_admin_user.obligations
start_time = DateTime.now-5.days
if @obligations.of_date(start_time).empty?
	@obligation = Obligation.find_or_create_by(name: "Kendo Class", start_time: start_time, end_time: start_time+2.hours, city: "Los Angeles", state_id: State.find_by_abbr("CA").id, user_id: @my_admin_user.id, obligation_color_id: @obligation_color.id)
	puts @obligation.inspect
end

start_time = DateTime.now-4.days
if @obligations.of_date(start_time).empty?
	@obligation = Obligation.find_or_create_by(name: "Cousin's Wedding", start_time: start_time, end_time: nil, city: "Chicago", state_id: State.find_by_abbr("IL").id, user_id: @my_admin_user.id, obligation_color_id: @obligation_color.id)
	puts @obligation.inspect
end

start_time = DateTime.now-1.hour
if @obligations.of_date(start_time).empty?
	@obligation = Obligation.find_or_create_by(name: "Attend Meeting", start_time: start_time, end_time: DateTime.now, city: "Los Angeles", state_id: State.find_by_abbr("CA").id, user_id: @my_admin_user.id, obligation_color_id: @obligation_color.id)
	puts @obligation.inspect
end
puts ""
puts ""