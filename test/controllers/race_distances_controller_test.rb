require 'test_helper'

class RaceDistancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @race_distance = race_distances(:one)
  end

  test "should get index" do
    get race_distances_url
    assert_response :success
  end

  test "should get new" do
    get new_race_distance_url
    assert_response :success
  end

  test "should create race_distance" do
    assert_difference('RaceDistance.count') do
      post race_distances_url, params: { race_distance: { distance: @race_distance.distance } }
    end

    assert_redirected_to race_distance_url(RaceDistance.last)
  end

  test "should show race_distance" do
    get race_distance_url(@race_distance)
    assert_response :success
  end

  test "should get edit" do
    get edit_race_distance_url(@race_distance)
    assert_response :success
  end

  test "should update race_distance" do
    patch race_distance_url(@race_distance), params: { race_distance: { distance: @race_distance.distance } }
    assert_redirected_to race_distance_url(@race_distance)
  end

  test "should destroy race_distance" do
    assert_difference('RaceDistance.count', -1) do
      delete race_distance_url(@race_distance)
    end

    assert_redirected_to race_distances_url
  end
end
