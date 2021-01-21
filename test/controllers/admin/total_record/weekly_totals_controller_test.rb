require 'test_helper'

class Admin::TotalRecord::WeeklyTotalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_total_record_weekly_total = admin_total_record_weekly_totals(:one)
  end

  test "should get index" do
    get admin_total_record_weekly_totals_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_total_record_weekly_total_url
    assert_response :success
  end

  test "should create admin_total_record_weekly_total" do
    assert_difference('Admin::TotalRecord::WeeklyTotal.count') do
      post admin_total_record_weekly_totals_url, params: { admin_total_record_weekly_total: {  } }
    end

    assert_redirected_to admin_total_record_weekly_total_url(Admin::TotalRecord::WeeklyTotal.last)
  end

  test "should show admin_total_record_weekly_total" do
    get admin_total_record_weekly_total_url(@admin_total_record_weekly_total)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_total_record_weekly_total_url(@admin_total_record_weekly_total)
    assert_response :success
  end

  test "should update admin_total_record_weekly_total" do
    patch admin_total_record_weekly_total_url(@admin_total_record_weekly_total), params: { admin_total_record_weekly_total: {  } }
    assert_redirected_to admin_total_record_weekly_total_url(@admin_total_record_weekly_total)
  end

  test "should destroy admin_total_record_weekly_total" do
    assert_difference('Admin::TotalRecord::WeeklyTotal.count', -1) do
      delete admin_total_record_weekly_total_url(@admin_total_record_weekly_total)
    end

    assert_redirected_to admin_total_record_weekly_totals_url
  end
end
