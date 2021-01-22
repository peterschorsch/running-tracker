require 'test_helper'

class Admin::TotalRecord::YearlyTotalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_total_record_yearly_total = admin_total_record_yearly_totals(:one)
  end

  test "should get index" do
    get admin_total_record_yearly_totals_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_total_record_yearly_total_url
    assert_response :success
  end

  test "should create admin_total_record_yearly_total" do
    assert_difference('Admin::TotalRecord::YearlyTotal.count') do
      post admin_total_record_yearly_totals_url, params: { admin_total_record_yearly_total: {  } }
    end

    assert_redirected_to admin_total_record_yearly_total_url(Admin::TotalRecord::YearlyTotal.last)
  end

  test "should show admin_total_record_yearly_total" do
    get admin_total_record_yearly_total_url(@admin_total_record_yearly_total)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_total_record_yearly_total_url(@admin_total_record_yearly_total)
    assert_response :success
  end

  test "should update admin_total_record_yearly_total" do
    patch admin_total_record_yearly_total_url(@admin_total_record_yearly_total), params: { admin_total_record_yearly_total: {  } }
    assert_redirected_to admin_total_record_yearly_total_url(@admin_total_record_yearly_total)
  end

  test "should destroy admin_total_record_yearly_total" do
    assert_difference('Admin::TotalRecord::YearlyTotal.count', -1) do
      delete admin_total_record_yearly_total_url(@admin_total_record_yearly_total)
    end

    assert_redirected_to admin_total_record_yearly_totals_url
  end
end
