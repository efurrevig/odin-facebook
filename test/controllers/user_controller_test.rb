require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end
  
  test "should get index" do
    get user_index_url
    assert_response :success
  end

  test "should get edit" do
    get user_edit_url
    assert_response :success
  end
end
