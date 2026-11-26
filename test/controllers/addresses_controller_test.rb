require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  test "redirects unauthenticated users to login" do
    get edit_addresses_path

    assert_redirected_to new_user_session_path
  end
end