require 'test_helper'

class RunsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @run = runs(:one)
  end

  test "should get index" do
    get runs_url
    assert_response :success
  end

  test "should get new" do
    get new_run_url
    assert_response :success
  end

  test "should create run" do
    assert_difference('Run.count') do
      post runs_url, params: { run: { avg_heart_rate: @run.avg_heart_rate, city: @run.city, distance: @run.distance, elevation_gain: @run.elevation_gain, hours: @run.hours, max_heart_rate: @run.max_heart_rate, minutes: @run.minutes, notes: @run.notes, pace: @run.pace, personal_best: @run.personal_best, seconds: @run.seconds } }
    end

    assert_redirected_to run_url(Run.last)
  end

  test "should show run" do
    get run_url(@run)
    assert_response :success
  end

  test "should get edit" do
    get edit_run_url(@run)
    assert_response :success
  end

  test "should update run" do
    patch run_url(@run), params: { run: { avg_heart_rate: @run.avg_heart_rate, city: @run.city, distance: @run.distance, elevation_gain: @run.elevation_gain, hours: @run.hours, max_heart_rate: @run.max_heart_rate, minutes: @run.minutes, notes: @run.notes, pace: @run.pace, personal_best: @run.personal_best, seconds: @run.seconds } }
    assert_redirected_to run_url(@run)
  end

  test "should destroy run" do
    assert_difference('Run.count', -1) do
      delete run_url(@run)
    end

    assert_redirected_to runs_url
  end
end
