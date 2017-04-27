require 'test_helper'

class OhQueuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @oh_queue = oh_queues(:one)
  end

  test "should get index" do
    get oh_queues_url
    assert_response :success
  end

  test "should get new" do
    get new_oh_queue_url
    assert_response :success
  end

  test "should create oh_queue" do
    assert_difference('OhQueue.count') do
      post oh_queues_url, params: { oh_queue: {  } }
    end

    assert_redirected_to oh_queue_url(OhQueue.last)
  end

  test "should show oh_queue" do
    get oh_queue_url(@oh_queue)
    assert_response :success
  end

  test "should get edit" do
    get edit_oh_queue_url(@oh_queue)
    assert_response :success
  end

  test "should update oh_queue" do
    patch oh_queue_url(@oh_queue), params: { oh_queue: {  } }
    assert_redirected_to oh_queue_url(@oh_queue)
  end

  test "should destroy oh_queue" do
    assert_difference('OhQueue.count', -1) do
      delete oh_queue_url(@oh_queue)
    end

    assert_redirected_to oh_queues_url
  end
end
