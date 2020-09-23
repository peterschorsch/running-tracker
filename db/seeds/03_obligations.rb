puts "----------OBLIGATIONS----------"
@obligation = Obligation.find_or_create_by(name: "Kendo", start_datetime: DateTime.new(2020, 9, 29, 20, 0, 0).in_time_zone("Central Time (US & Canada)"), end_datetime: DateTime.new(2020, 9, 29, 22, 0, 0).in_time_zone("Central Time (US & Canada)"), city: "Los Angeles", :state_id => State.find_by_abbr("CA").id)
puts @obligation.inspect
@obligation = Obligation.find_or_create_by(name: "Jeff's Wedding", start_datetime: DateTime.new(2020, 9, 5, 16, 30, 0).in_time_zone("Central Time (US & Canada)"), end_datetime: DateTime.new(2020, 9, 5, 23, 0, 0).in_time_zone("Central Time (US & Canada)"), city: "Chicago", :state_id => State.find_by_abbr("IL").id)
puts @obligation.inspect
@obligation = Obligation.find_or_create_by(name: "Meeting", start_datetime: DateTime.new(2020, 9, 16, 10, 15, 30).in_time_zone("Pacific Time (US & Canada)"), end_datetime: DateTime.new(2020, 9, 16, 10, 45, 0).in_time_zone("Pacific Time (US & Canada)"), city: "Seattle", :state_id => State.find_by_abbr("WA").id)
puts @obligation.inspect
puts ""
puts ""