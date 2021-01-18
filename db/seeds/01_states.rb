CS.states(:us).each do |abbreviation, state_name|
  State.find_or_create_by(abbreviation: abbreviation, name: state_name)
end
puts "SEEDED #{CS.states(:us).count} States"


CS.countries.each do |abbreviation, country_name|
  Country.find_or_create_by(abbreviation: abbreviation, name: country_name)
end
Country.find_by_name("United States").update_columns(:name => "United States of America", :abbreviation => "USA")
Country.find_by_name("United States").update_columns(:name => "United States of America", :abbreviation => "USA")
puts "SEEDED #{CS.countries.count} Countries"
puts ""
puts ""