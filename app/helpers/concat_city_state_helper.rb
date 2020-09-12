module ConcatCityStateHelper

  def concat_city_state_full(city, state)
    city + ", " + state.name
  end

  def concat_city_state_abbreviation(city, state)
    city + ", " + state.abbreviation
  end

end