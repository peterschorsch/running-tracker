require 'test_helper'

class PersonalBestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @personal_best = personal_bests(:one)
  end

  test "should get index" do
    get personal_bests_url
    assert_response :success
  end

  test "should get new" do
    get new_personal_best_url
    assert_response :success
  end

  test "should create personal_best" do
    assert_difference('PersonalBest.count') do
      post personal_bests_url, params: { personal_best: { city: @personal_best.city, hours: @personal_best.hours, minutes: @personal_best.minutes, name: @personal_best.name, notes: @personal_best.notes, pace: @personal_best.pace, race_datetime: @personal_best.race_datetime, seconds: @personal_best.seconds } }
    end

    assert_redirected_to personal_best_url(PersonalBest.last)
  end

  test "should show personal_best" do
    get personal_best_url(@personal_best)
    assert_response :success
  end

  test "should get edit" do
    get edit_personal_best_url(@personal_best)
    assert_response :success
  end

  test "should update personal_best" do
    patch personal_best_url(@personal_best), params: { personal_best: { city: @personal_best.city, hours: @personal_best.hours, minutes: @personal_best.minutes, name: @personal_best.name, notes: @personal_best.notes, pace: @personal_best.pace, race_datetime: @personal_best.race_datetime, seconds: @personal_best.seconds } }
    assert_redirected_to personal_best_url(@personal_best)
  end

  test "should destroy personal_best" do
    assert_difference('PersonalBest.count', -1) do
      delete personal_best_url(@personal_best)
    end

    assert_redirected_to personal_bests_url
  end
end
