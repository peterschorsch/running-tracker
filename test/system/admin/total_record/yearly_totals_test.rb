require "application_system_test_case"

class Admin::TotalRecord::YearlyTotalsTest < ApplicationSystemTestCase
  setup do
    @admin_total_record_yearly_total = admin_total_record_yearly_totals(:one)
  end

  test "visiting the index" do
    visit admin_total_record_yearly_totals_url
    assert_selector "h1", text: "Admin/Total Record/Yearly Totals"
  end

  test "creating a Yearly total" do
    visit admin_total_record_yearly_totals_url
    click_on "New Admin/Total Record/Yearly Total"

    click_on "Create Yearly total"

    assert_text "Yearly total was successfully created"
    click_on "Back"
  end

  test "updating a Yearly total" do
    visit admin_total_record_yearly_totals_url
    click_on "Edit", match: :first

    click_on "Update Yearly total"

    assert_text "Yearly total was successfully updated"
    click_on "Back"
  end

  test "destroying a Yearly total" do
    visit admin_total_record_yearly_totals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Yearly total was successfully destroyed"
  end
end
