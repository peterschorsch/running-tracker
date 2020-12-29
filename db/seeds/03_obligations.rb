puts "----------OBLIGATIONS----------"
@my_admin_user = User.find_user_by_name("Peter","Schorsch")

@obligation = Obligation.find_or_create_by(name: "Kendo", start_time: DateTime.now-5.days, end_time: DateTime.now-5.days, city: "Los Angeles", state_id: State.find_by_abbr("CA").id, user_id: @my_admin_user.id)
puts @obligation.inspect
@obligation = Obligation.find_or_create_by(name: "Jeff's Wedding", start_time: DateTime.now-4.days, end_time: nil, city: "Chicago", state_id: State.find_by_abbr("IL").id, user_id: @my_admin_user.id)
puts @obligation.inspect
@obligation = Obligation.find_or_create_by(name: "Meeting", start_time: DateTime.now-1.hour, end_time: DateTime.now, city: "Seattle", state_id: State.find_by_abbr("WA").id, user_id: @my_admin_user.id)
puts @obligation.inspect
puts ""
puts ""