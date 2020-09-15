require "application_system_test_case"

class Admin::ShoeBrandsTest < ApplicationSystemTestCase
  setup do
    @admin_shoe_brand = admin_shoe_brands(:one)
  end

  test "visiting the index" do
    visit admin_shoe_brands_url
    assert_selector "h1", text: "Admin/Shoe Brands"
  end

  test "creating a Shoe brand" do
    visit admin_shoe_brands_url
    click_on "New Admin/Shoe Brand"

    click_on "Create Shoe brand"

    assert_text "Shoe brand was successfully created"
    click_on "Back"
  end

  test "updating a Shoe brand" do
    visit admin_shoe_brands_url
    click_on "Edit", match: :first

    click_on "Update Shoe brand"

    assert_text "Shoe brand was successfully updated"
    click_on "Back"
  end

  test "destroying a Shoe brand" do
    visit admin_shoe_brands_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shoe brand was successfully destroyed"
  end
end
