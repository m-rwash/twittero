require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
  	@user = users(:testuser)
  	@other_user = users(:testuser2)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_path
  end

  test "should get signup" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign Up | Twittero"
  end

  test "should redirect edit when not logged in" do
	get edit_user_path(@user)
	assert_not flash.empty?
	assert_redirected_to login_path
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

end
