require "application_system_test_case"

class MonthlyTotalsTest < ApplicationSystemTestCase
  setup do
    @monthly_total = monthly_totals(:one)
  end

  test "visiting the index" do
    visit monthly_totals_url
    assert_selector "h1", text: "Monthly Totals"
  end

  test "creating a Monthly total" do
    visit monthly_totals_url
    click_on "New Monthly Total"

    fill_in "Elevation gain", with: @monthly_total.elevation_gain
    fill_in "Hours", with: @monthly_total.hours
    fill_in "Mileage total", with: @monthly_total.mileage_total
    fill_in "Minutes", with: @monthly_total.minutes
    fill_in "Month end", with: @monthly_total.month_end
    fill_in "Month number", with: @monthly_total.month_number
    fill_in "Month start", with: @monthly_total.month_start
    fill_in "Number of runs", with: @monthly_total.number_of_runs
    fill_in "Seconds", with: @monthly_total.seconds
    click_on "Create Monthly total"

    assert_text "Monthly total was successfully created"
    click_on "Back"
  end

  test "updating a Monthly total" do
    visit monthly_totals_url
    click_on "Edit", match: :first

    fill_in "Elevation gain", with: @monthly_total.elevation_gain
    fill_in "Hours", with: @monthly_total.hours
    fill_in "Mileage total", with: @monthly_total.mileage_total
    fill_in "Minutes", with: @monthly_total.minutes
    fill_in "Month end", with: @monthly_total.month_end
    fill_in "Month number", with: @monthly_total.month_number
    fill_in "Month start", with: @monthly_total.month_start
    fill_in "Number of runs", with: @monthly_total.number_of_runs
    fill_in "Seconds", with: @monthly_total.seconds
    click_on "Update Monthly total"

    assert_text "Monthly total was successfully updated"
    click_on "Back"
  end

  test "destroying a Monthly total" do
    visit monthly_totals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Monthly total was successfully destroyed"
  end
end
