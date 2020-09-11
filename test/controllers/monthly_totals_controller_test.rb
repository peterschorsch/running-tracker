require 'test_helper'

class MonthlyTotalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monthly_total = monthly_totals(:one)
  end

  test "should get index" do
    get monthly_totals_url
    assert_response :success
  end

  test "should get new" do
    get new_monthly_total_url
    assert_response :success
  end

  test "should create monthly_total" do
    assert_difference('MonthlyTotal.count') do
      post monthly_totals_url, params: { monthly_total: { elevation_gain: @monthly_total.elevation_gain, hours: @monthly_total.hours, mileage_total: @monthly_total.mileage_total, minutes: @monthly_total.minutes, month_end: @monthly_total.month_end, month_number: @monthly_total.month_number, month_start: @monthly_total.month_start, number_of_runs: @monthly_total.number_of_runs, seconds: @monthly_total.seconds } }
    end

    assert_redirected_to monthly_total_url(MonthlyTotal.last)
  end

  test "should show monthly_total" do
    get monthly_total_url(@monthly_total)
    assert_response :success
  end

  test "should get edit" do
    get edit_monthly_total_url(@monthly_total)
    assert_response :success
  end

  test "should update monthly_total" do
    patch monthly_total_url(@monthly_total), params: { monthly_total: { elevation_gain: @monthly_total.elevation_gain, hours: @monthly_total.hours, mileage_total: @monthly_total.mileage_total, minutes: @monthly_total.minutes, month_end: @monthly_total.month_end, month_number: @monthly_total.month_number, month_start: @monthly_total.month_start, number_of_runs: @monthly_total.number_of_runs, seconds: @monthly_total.seconds } }
    assert_redirected_to monthly_total_url(@monthly_total)
  end

  test "should destroy monthly_total" do
    assert_difference('MonthlyTotal.count', -1) do
      delete monthly_total_url(@monthly_total)
    end

    assert_redirected_to monthly_totals_url
  end
end
