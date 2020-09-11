require "application_system_test_case"

class PersonalBestsTest < ApplicationSystemTestCase
  setup do
    @personal_best = personal_bests(:one)
  end

  test "visiting the index" do
    visit personal_bests_url
    assert_selector "h1", text: "Personal Bests"
  end

  test "creating a Personal best" do
    visit personal_bests_url
    click_on "New Personal Best"

    fill_in "City", with: @personal_best.city
    fill_in "Hours", with: @personal_best.hours
    fill_in "Minutes", with: @personal_best.minutes
    fill_in "Name", with: @personal_best.name
    fill_in "Notes", with: @personal_best.notes
    fill_in "Pace", with: @personal_best.pace
    fill_in "Race datetime", with: @personal_best.race_datetime
    fill_in "Seconds", with: @personal_best.seconds
    click_on "Create Personal best"

    assert_text "Personal best was successfully created"
    click_on "Back"
  end

  test "updating a Personal best" do
    visit personal_bests_url
    click_on "Edit", match: :first

    fill_in "City", with: @personal_best.city
    fill_in "Hours", with: @personal_best.hours
    fill_in "Minutes", with: @personal_best.minutes
    fill_in "Name", with: @personal_best.name
    fill_in "Notes", with: @personal_best.notes
    fill_in "Pace", with: @personal_best.pace
    fill_in "Race datetime", with: @personal_best.race_datetime
    fill_in "Seconds", with: @personal_best.seconds
    click_on "Update Personal best"

    assert_text "Personal best was successfully updated"
    click_on "Back"
  end

  test "destroying a Personal best" do
    visit personal_bests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Personal best was successfully destroyed"
  end
end
