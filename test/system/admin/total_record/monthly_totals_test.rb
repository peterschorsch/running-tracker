require "application_system_test_case"

class Admin::TotalRecord::MonthlyTotalsTest < ApplicationSystemTestCase
  setup do
    @admin_total_record_monthly_total = admin_total_record_monthly_totals(:one)
  end

  test "visiting the index" do
    visit admin_total_record_monthly_totals_url
    assert_selector "h1", text: "Admin/Total Record/Monthly Totals"
  end

  test "creating a Monthly total" do
    visit admin_total_record_monthly_totals_url
    click_on "New Admin/Total Record/Monthly Total"

    click_on "Create Monthly total"

    assert_text "Monthly total was successfully created"
    click_on "Back"
  end

  test "updating a Monthly total" do
    visit admin_total_record_monthly_totals_url
    click_on "Edit", match: :first

    click_on "Update Monthly total"

    assert_text "Monthly total was successfully updated"
    click_on "Back"
  end

  test "destroying a Monthly total" do
    visit admin_total_record_monthly_totals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Monthly total was successfully destroyed"
  end
end
