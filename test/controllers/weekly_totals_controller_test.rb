require 'test_helper'

class WeeklyTotalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weekly_total = weekly_totals(:one)
  end

  test "should get index" do
    get weekly_totals_url
    assert_response :success
  end

  test "should get new" do
    get new_weekly_total_url
    assert_response :success
  end

  test "should create weekly_total" do
    assert_difference('WeeklyTotal.count') do
      post weekly_totals_url, params: { weekly_total: { elevation_gain: @weekly_total.elevation_gain, goal: @weekly_total.goal, hours: @weekly_total.hours, met_goal: @weekly_total.met_goal, mileage_total: @weekly_total.mileage_total, minutes: @weekly_total.minutes, notes: @weekly_total.notes, number_of_runs: @weekly_total.number_of_runs, seconds: @weekly_total.seconds, week_end: @weekly_total.week_end, week_number: @weekly_total.week_number, week_start: @weekly_total.week_start } }
    end

    assert_redirected_to weekly_total_url(WeeklyTotal.last)
  end

  test "should show weekly_total" do
    get weekly_total_url(@weekly_total)
    assert_response :success
  end

  test "should get edit" do
    get edit_weekly_total_url(@weekly_total)
    assert_response :success
  end

  test "should update weekly_total" do
    patch weekly_total_url(@weekly_total), params: { weekly_total: { elevation_gain: @weekly_total.elevation_gain, goal: @weekly_total.goal, hours: @weekly_total.hours, met_goal: @weekly_total.met_goal, mileage_total: @weekly_total.mileage_total, minutes: @weekly_total.minutes, notes: @weekly_total.notes, number_of_runs: @weekly_total.number_of_runs, seconds: @weekly_total.seconds, week_end: @weekly_total.week_end, week_number: @weekly_total.week_number, week_start: @weekly_total.week_start } }
    assert_redirected_to weekly_total_url(@weekly_total)
  end

  test "should destroy weekly_total" do
    assert_difference('WeeklyTotal.count', -1) do
      delete weekly_total_url(@weekly_total)
    end

    assert_redirected_to weekly_totals_url
  end
end
