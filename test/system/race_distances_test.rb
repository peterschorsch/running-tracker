require "application_system_test_case"

class RaceDistancesTest < ApplicationSystemTestCase
  setup do
    @race_distance = race_distances(:one)
  end

  test "visiting the index" do
    visit race_distances_url
    assert_selector "h1", text: "Race Distances"
  end

  test "creating a Race distance" do
    visit race_distances_url
    click_on "New Race Distance"

    fill_in "Distance", with: @race_distance.distance
    click_on "Create Race distance"

    assert_text "Race distance was successfully created"
    click_on "Back"
  end

  test "updating a Race distance" do
    visit race_distances_url
    click_on "Edit", match: :first

    fill_in "Distance", with: @race_distance.distance
    click_on "Update Race distance"

    assert_text "Race distance was successfully updated"
    click_on "Back"
  end

  test "destroying a Race distance" do
    visit race_distances_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Race distance was successfully destroyed"
  end
end
