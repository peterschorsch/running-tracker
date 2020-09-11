require "application_system_test_case"

class WeeklyTotalsTest < ApplicationSystemTestCase
  setup do
    @weekly_total = weekly_totals(:one)
  end

  test "visiting the index" do
    visit weekly_totals_url
    assert_selector "h1", text: "Weekly Totals"
  end

  test "creating a Weekly total" do
    visit weekly_totals_url
    click_on "New Weekly Total"

    fill_in "Elevation gain", with: @weekly_total.elevation_gain
    fill_in "Goal", with: @weekly_total.goal
    fill_in "Hours", with: @weekly_total.hours
    check "Met goal" if @weekly_total.met_goal
    fill_in "Mileage total", with: @weekly_total.mileage_total
    fill_in "Minutes", with: @weekly_total.minutes
    fill_in "Notes", with: @weekly_total.notes
    fill_in "Number of runs", with: @weekly_total.number_of_runs
    fill_in "Seconds", with: @weekly_total.seconds
    fill_in "Week end", with: @weekly_total.week_end
    fill_in "Week number", with: @weekly_total.week_number
    fill_in "Week start", with: @weekly_total.week_start
    click_on "Create Weekly total"

    assert_text "Weekly total was successfully created"
    click_on "Back"
  end

  test "updating a Weekly total" do
    visit weekly_totals_url
    click_on "Edit", match: :first

    fill_in "Elevation gain", with: @weekly_total.elevation_gain
    fill_in "Goal", with: @weekly_total.goal
    fill_in "Hours", with: @weekly_total.hours
    check "Met goal" if @weekly_total.met_goal
    fill_in "Mileage total", with: @weekly_total.mileage_total
    fill_in "Minutes", with: @weekly_total.minutes
    fill_in "Notes", with: @weekly_total.notes
    fill_in "Number of runs", with: @weekly_total.number_of_runs
    fill_in "Seconds", with: @weekly_total.seconds
    fill_in "Week end", with: @weekly_total.week_end
    fill_in "Week number", with: @weekly_total.week_number
    fill_in "Week start", with: @weekly_total.week_start
    click_on "Update Weekly total"

    assert_text "Weekly total was successfully updated"
    click_on "Back"
  end

  test "destroying a Weekly total" do
    visit weekly_totals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Weekly total was successfully destroyed"
  end
end
