require 'test_helper'

class RunTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @run_type = run_types(:one)
  end

  test "should get index" do
    get run_types_url
    assert_response :success
  end

  test "should get new" do
    get new_run_type_url
    assert_response :success
  end

  test "should create run_type" do
    assert_difference('RunType.count') do
      post run_types_url, params: { run_type: { default: @run_type.default, hex_code: @run_type.hex_code, name: @run_type.name } }
    end

    assert_redirected_to run_type_url(RunType.last)
  end

  test "should show run_type" do
    get run_type_url(@run_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_run_type_url(@run_type)
    assert_response :success
  end

  test "should update run_type" do
    patch run_type_url(@run_type), params: { run_type: { default: @run_type.default, hex_code: @run_type.hex_code, name: @run_type.name } }
    assert_redirected_to run_type_url(@run_type)
  end

  test "should destroy run_type" do
    assert_difference('RunType.count', -1) do
      delete run_type_url(@run_type)
    end

    assert_redirected_to run_types_url
  end
end
