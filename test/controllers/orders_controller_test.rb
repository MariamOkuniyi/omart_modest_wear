require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "orders require customer login" do
    order = orders(:one)

    get order_path(order)

    assert_redirected_to new_user_session_path
  end
end