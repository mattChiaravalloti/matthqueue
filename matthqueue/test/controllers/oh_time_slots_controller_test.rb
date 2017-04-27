require 'test_helper'

class OhTimeSlotsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @oh_time_slot = oh_time_slots(:one)
  end

  test "should get index" do
    get oh_time_slots_url
    assert_response :success
  end

  test "should get new" do
    get new_oh_time_slot_url
    assert_response :success
  end

  test "should create oh_time_slot" do
    assert_difference('OhTimeSlot.count') do
      post oh_time_slots_url, params: { oh_time_slot: {  } }
    end

    assert_redirected_to oh_time_slot_url(OhTimeSlot.last)
  end

  test "should show oh_time_slot" do
    get oh_time_slot_url(@oh_time_slot)
    assert_response :success
  end

  test "should get edit" do
    get edit_oh_time_slot_url(@oh_time_slot)
    assert_response :success
  end

  test "should update oh_time_slot" do
    patch oh_time_slot_url(@oh_time_slot), params: { oh_time_slot: {  } }
    assert_redirected_to oh_time_slot_url(@oh_time_slot)
  end

  test "should destroy oh_time_slot" do
    assert_difference('OhTimeSlot.count', -1) do
      delete oh_time_slot_url(@oh_time_slot)
    end

    assert_redirected_to oh_time_slots_url
  end
end
