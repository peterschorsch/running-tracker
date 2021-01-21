puts "----------OBLIGATIONS----------"
@my_admin_user = User.find_user_by_name("Peter","Schorsch")
@website_viewer = User.return_website_viewer

@obligation_color = ObligationColor.find_or_create_by(name: "Default Color - Black", hex_code: "#17202A")
puts @obligation_color.inspect


### TESTING FOR MYSELF - TEMPORARY - FIX ###
@obligations = @my_admin_user.obligations
start_time = DateTime.current-5.days
if @obligations.of_day(start_time).empty?
	@obligation = Obligation.find_or_create_by(name: "Kendo Class", start_time: start_time, end_time: start_time+2.hours, city: @my_admin_user.default_city, state_id: State.find_by_name(@my_admin_user.default_state).id, user_id: @my_admin_user.id, obligation_color_id: @obligation_color.id)
	puts @obligation.inspect
end

start_time = DateTime.current-4.days
if @obligations.of_day(start_time).empty?
	@obligation = Obligation.find_or_create_by(name: "Cousin's Wedding", start_time: start_time, end_time: nil, city: "Chicago", state_id: State.find_by_abbr("IL").id, user_id: @my_admin_user.id, obligation_color_id: @obligation_color.id)
	puts @obligation.inspect
end

start_time = DateTime.current-1.hour
if @obligations.of_day(start_time).empty?
	@obligation = Obligation.find_or_create_by(name: "Attend Meeting", start_time: start_time, end_time: DateTime.current, city: @my_admin_user.default_city, state_id: State.find_by_name(@my_admin_user.default_state).id, user_id: @my_admin_user.id, obligation_color_id: @obligation_color.id)
	puts @obligation.inspect
end
puts ""
puts ""