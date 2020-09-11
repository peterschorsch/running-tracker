require "application_system_test_case"

class YearlyTotalsTest < ApplicationSystemTestCase
  setup do
    @yearly_total = yearly_totals(:one)
  end

  test "visiting the index" do
    visit yearly_totals_url
    assert_selector "h1", text: "Yearly Totals"
  end

  test "creating a Yearly total" do
    visit yearly_totals_url
    click_on "New Yearly Total"

    fill_in "Hours", with: @yearly_total.hours
    fill_in "Mileage total", with: @yearly_total.mileage_total
    fill_in "Minutes", with: @yearly_total.minutes
    fill_in "Number of runs", with: @yearly_total.number_of_runs
    fill_in "Seconds", with: @yearly_total.seconds
    fill_in "Year", with: @yearly_total.year
    click_on "Create Yearly total"

    assert_text "Yearly total was successfully created"
    click_on "Back"
  end

  test "updating a Yearly total" do
    visit yearly_totals_url
    click_on "Edit", match: :first

    fill_in "Hours", with: @yearly_total.hours
    fill_in "Mileage total", with: @yearly_total.mileage_total
    fill_in "Minutes", with: @yearly_total.minutes
    fill_in "Number of runs", with: @yearly_total.number_of_runs
    fill_in "Seconds", with: @yearly_total.seconds
    fill_in "Year", with: @yearly_total.year
    click_on "Update Yearly total"

    assert_text "Yearly total was successfully updated"
    click_on "Back"
  end

  test "destroying a Yearly total" do
    visit yearly_totals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Yearly total was successfully destroyed"
  end
end
