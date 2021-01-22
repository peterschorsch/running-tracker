require "application_system_test_case"

class Admin::TotalRecord::WeeklyTotalsTest < ApplicationSystemTestCase
  setup do
    @admin_total_record_weekly_total = admin_total_record_weekly_totals(:one)
  end

  test "visiting the index" do
    visit admin_total_record_weekly_totals_url
    assert_selector "h1", text: "Admin/Total Record/Weekly Totals"
  end

  test "creating a Weekly total" do
    visit admin_total_record_weekly_totals_url
    click_on "New Admin/Total Record/Weekly Total"

    click_on "Create Weekly total"

    assert_text "Weekly total was successfully created"
    click_on "Back"
  end

  test "updating a Weekly total" do
    visit admin_total_record_weekly_totals_url
    click_on "Edit", match: :first

    click_on "Update Weekly total"

    assert_text "Weekly total was successfully updated"
    click_on "Back"
  end

  test "destroying a Weekly total" do
    visit admin_total_record_weekly_totals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Weekly total was successfully destroyed"
  end
end
