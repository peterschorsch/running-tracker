require 'test_helper'

class ObligationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @obligation = obligations(:one)
  end

  test "should get index" do
    get obligations_url
    assert_response :success
  end

  test "should get new" do
    get new_obligation_url
    assert_response :success
  end

  test "should create obligation" do
    assert_difference('Obligation.count') do
      post obligations_url, params: { obligation: {  } }
    end

    assert_redirected_to obligation_url(Obligation.last)
  end

  test "should show obligation" do
    get obligation_url(@obligation)
    assert_response :success
  end

  test "should get edit" do
    get edit_obligation_url(@obligation)
    assert_response :success
  end

  test "should update obligation" do
    patch obligation_url(@obligation), params: { obligation: {  } }
    assert_redirected_to obligation_url(@obligation)
  end

  test "should destroy obligation" do
    assert_difference('Obligation.count', -1) do
      delete obligation_url(@obligation)
    end

    assert_redirected_to obligations_url
  end
end
