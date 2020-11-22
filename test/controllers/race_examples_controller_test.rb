require 'test_helper'

class RaceExamplesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @race_example = race_examples(:one)
  end

  test "should get index" do
    get race_examples_url
    assert_response :success
  end

  test "should get new" do
    get new_race_example_url
    assert_response :success
  end

  test "should create race_example" do
    assert_difference('RaceExample.count') do
      post race_examples_url, params: { race_example: {  } }
    end

    assert_redirected_to race_example_url(RaceExample.last)
  end

  test "should show race_example" do
    get race_example_url(@race_example)
    assert_response :success
  end

  test "should get edit" do
    get edit_race_example_url(@race_example)
    assert_response :success
  end

  test "should update race_example" do
    patch race_example_url(@race_example), params: { race_example: {  } }
    assert_redirected_to race_example_url(@race_example)
  end

  test "should destroy race_example" do
    assert_difference('RaceExample.count', -1) do
      delete race_example_url(@race_example)
    end

    assert_redirected_to race_examples_url
  end
end
