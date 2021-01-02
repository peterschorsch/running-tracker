require "application_system_test_case"

class UserRolesTest < ApplicationSystemTestCase
  setup do
    @user_role = user_roles(:one)
  end

  test "visiting the index" do
    visit user_roles_url
    assert_selector "h1", text: "User Roles"
  end

  test "creating a User role" do
    visit user_roles_url
    click_on "New User Role"

    fill_in "Name", with: @user_role.name
    click_on "Create User role"

    assert_text "User role was successfully created"
    click_on "Back"
  end

  test "updating a User role" do
    visit user_roles_url
    click_on "Edit", match: :first

    fill_in "Name", with: @user_role.name
    click_on "Update User role"

    assert_text "User role was successfully updated"
    click_on "Back"
  end

  test "destroying a User role" do
    visit user_roles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User role was successfully destroyed"
  end
end
