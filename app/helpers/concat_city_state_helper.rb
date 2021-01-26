module ConcatCityStateHelper

  def concat_city_state_full(record)
	location = record.city + ", "
	location += record.state_id.nil? ? record.country.name : record.state.name
  end

  def concat_city_state_abbreviation(record)
	location = record.city + ", "
	location += record.state_id.nil? ? record.country.name : record.state.abbreviation
  end

end