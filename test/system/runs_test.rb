require "application_system_test_case"

class RunsTest < ApplicationSystemTestCase
  setup do
    @run = runs(:one)
  end

  test "visiting the index" do
    visit runs_url
    assert_selector "h1", text: "Runs"
  end

  test "creating a Run" do
    visit runs_url
    click_on "New Run"

    fill_in "Avg heart rate", with: @run.avg_heart_rate
    fill_in "City", with: @run.city
    fill_in "Distance", with: @run.distance
    fill_in "Elevation gain", with: @run.elevation_gain
    fill_in "Hours", with: @run.hours
    fill_in "Max heart rate", with: @run.max_heart_rate
    fill_in "Minutes", with: @run.minutes
    fill_in "Notes", with: @run.notes
    fill_in "Pace", with: @run.pace
    check "Personal best" if @run.personal_best
    fill_in "Seconds", with: @run.seconds
    click_on "Create Run"

    assert_text "Run was successfully created"
    click_on "Back"
  end

  test "updating a Run" do
    visit runs_url
    click_on "Edit", match: :first

    fill_in "Avg heart rate", with: @run.avg_heart_rate
    fill_in "City", with: @run.city
    fill_in "Distance", with: @run.distance
    fill_in "Elevation gain", with: @run.elevation_gain
    fill_in "Hours", with: @run.hours
    fill_in "Max heart rate", with: @run.max_heart_rate
    fill_in "Minutes", with: @run.minutes
    fill_in "Notes", with: @run.notes
    fill_in "Pace", with: @run.pace
    check "Personal best" if @run.personal_best
    fill_in "Seconds", with: @run.seconds
    click_on "Update Run"

    assert_text "Run was successfully updated"
    click_on "Back"
  end

  test "destroying a Run" do
    visit runs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Run was successfully destroyed"
  end
end
