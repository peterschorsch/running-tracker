require 'test_helper'

class Admin::ShoeBrandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_shoe_brand = admin_shoe_brands(:one)
  end

  test "should get index" do
    get admin_shoe_brands_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_shoe_brand_url
    assert_response :success
  end

  test "should create admin_shoe_brand" do
    assert_difference('Admin::ShoeBrand.count') do
      post admin_shoe_brands_url, params: { admin_shoe_brand: {  } }
    end

    assert_redirected_to admin_shoe_brand_url(Admin::ShoeBrand.last)
  end

  test "should show admin_shoe_brand" do
    get admin_shoe_brand_url(@admin_shoe_brand)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_shoe_brand_url(@admin_shoe_brand)
    assert_response :success
  end

  test "should update admin_shoe_brand" do
    patch admin_shoe_brand_url(@admin_shoe_brand), params: { admin_shoe_brand: {  } }
    assert_redirected_to admin_shoe_brand_url(@admin_shoe_brand)
  end

  test "should destroy admin_shoe_brand" do
    assert_difference('Admin::ShoeBrand.count', -1) do
      delete admin_shoe_brand_url(@admin_shoe_brand)
    end

    assert_redirected_to admin_shoe_brands_url
  end
end
