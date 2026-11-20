require "application_system_test_case"

class AdminLoginsTest < ApplicationSystemTestCase
  test "administrator login page is accessible" do
    visit new_admin_user_session_path

    assert_selector "h2", text: "Log in"
    assert_selector "input[type='email']"
    assert_selector "input[type='password']"
  end
end
