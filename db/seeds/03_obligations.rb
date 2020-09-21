puts "----------OBLIGATIONS----------"
@obligation = Obligation.find_or_create_by(name: "Kendo", start_datetime: DateTime.new(2020, 9, 29, 20, 0, 0), end_datetime: DateTime.new(2020, 9, 29, 22, 0, 0), city: "Los Angeles", :state_id => State.find_by_abbr("CA").id)
puts @obligation.inspect
@obligation = Obligation.find_or_create_by(name: "Jeff's Wedding", start_datetime: DateTime.new(2020, 9, 5, 16, 30, 0), end_datetime: DateTime.new(2020, 9, 5, 23, 0, 0), city: "Chicago", :state_id => State.find_by_abbr("IL").id)
puts @obligation.inspect
@obligation = Obligation.find_or_create_by(name: "Meeting", start_datetime: DateTime.new(2020, 9, 16, 10, 15, 30), end_datetime: DateTime.new(2020, 9, 16, 10, 45, 0), city: "Seattle", :state_id => State.find_by_abbr("WA").id)
puts @obligation.inspect
puts ""
puts ""