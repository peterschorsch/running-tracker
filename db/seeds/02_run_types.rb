puts "----------RUN TYPES----------"
type = "Easy Run"
@runtype = RunType.create_with(name: type, hex_code: "#6A0DAD", active: true, default: false).find_or_create_by(name: type)
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

type = "Speed Run"
@runtype = RunType.create_with(name: type, hex_code: "#1E90FF", active: true, default: false).find_or_create_by(name: type)
puts @runtype.inspect

type = "Tempo Run"
@runtype = RunType.create_with(name: type, hex_code: "#228B22", active: true, default: false).find_or_create_by(name: type)
puts @runtype.inspect

puts ""
puts ""