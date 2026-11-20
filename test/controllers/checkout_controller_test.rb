require "test_helper"

class CheckoutControllerTest < ActionDispatch::IntegrationTest
  test "checkout requires customer login" do
    get checkout_path

    assert_redirected_to new_user_session_path
  end
end