require 'test_helper'

class YearlyTotalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @yearly_total = yearly_totals(:one)
  end

  test "should get index" do
    get yearly_totals_url
    assert_response :success
  end

  test "should get new" do
    get new_yearly_total_url
    assert_response :success
  end

  test "should create yearly_total" do
    assert_difference('YearlyTotal.count') do
      post yearly_totals_url, params: { yearly_total: { hours: @yearly_total.hours, mileage_total: @yearly_total.mileage_total, minutes: @yearly_total.minutes, number_of_runs: @yearly_total.number_of_runs, seconds: @yearly_total.seconds, year: @yearly_total.year } }
    end

    assert_redirected_to yearly_total_url(YearlyTotal.last)
  end

  test "should show yearly_total" do
    get yearly_total_url(@yearly_total)
    assert_response :success
  end

  test "should get edit" do
    get edit_yearly_total_url(@yearly_total)
    assert_response :success
  end

  test "should update yearly_total" do
    patch yearly_total_url(@yearly_total), params: { yearly_total: { hours: @yearly_total.hours, mileage_total: @yearly_total.mileage_total, minutes: @yearly_total.minutes, number_of_runs: @yearly_total.number_of_runs, seconds: @yearly_total.seconds, year: @yearly_total.year } }
    assert_redirected_to yearly_total_url(@yearly_total)
  end

  test "should destroy yearly_total" do
    assert_difference('YearlyTotal.count', -1) do
      delete yearly_total_url(@yearly_total)
    end

    assert_redirected_to yearly_totals_url
  end
end
