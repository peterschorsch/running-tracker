CS.states(:us).each do |abbreviation, state_name|
  State.find_or_create_by(abbreviation: abbreviation, name: state_name)
end
puts "SEEDED #{CS.states(:us).count} States"


CS.countries.each do |abbreviation, country_name|
  Country.find_or_create_by(abbreviation: abbreviation, name: country_name)
end

puts "SEEDED #{CS.countries.count} Countries"
puts ""
puts ""