require "application_system_test_case"

class RaceExamplesTest < ApplicationSystemTestCase
  setup do
    @race_example = race_examples(:one)
  end

  test "visiting the index" do
    visit race_examples_url
    assert_selector "h1", text: "Race Examples"
  end

  test "creating a Race example" do
    visit race_examples_url
    click_on "New Race Example"

    click_on "Create Race example"

    assert_text "Race example was successfully created"
    click_on "Back"
  end

  test "updating a Race example" do
    visit race_examples_url
    click_on "Edit", match: :first

    click_on "Update Race example"

    assert_text "Race example was successfully updated"
    click_on "Back"
  end

  test "destroying a Race example" do
    visit race_examples_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Race example was successfully destroyed"
  end
end
