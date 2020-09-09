require "application_system_test_case"

class RunTypesTest < ApplicationSystemTestCase
  setup do
    @run_type = run_types(:one)
  end

  test "visiting the index" do
    visit run_types_url
    assert_selector "h1", text: "Run Types"
  end

  test "creating a Run type" do
    visit run_types_url
    click_on "New Run Type"

    check "Default" if @run_type.default
    fill_in "Hex code", with: @run_type.hex_code
    fill_in "Name", with: @run_type.name
    click_on "Create Run type"

    assert_text "Run type was successfully created"
    click_on "Back"
  end

  test "updating a Run type" do
    visit run_types_url
    click_on "Edit", match: :first

    check "Default" if @run_type.default
    fill_in "Hex code", with: @run_type.hex_code
    fill_in "Name", with: @run_type.name
    click_on "Update Run type"

    assert_text "Run type was successfully updated"
    click_on "Back"
  end

  test "destroying a Run type" do
    visit run_types_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Run type was successfully destroyed"
  end
end
