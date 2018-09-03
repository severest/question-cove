require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should not get edit if not the same user" do
    users = create_list(:user, 2)
    session[:user_id] = users[0].id
    get :edit, params: { id: users[1] }
    assert_redirected_to user_path(users[1])
  end

  test "should get edit screen" do
    user = create(:user)
    session[:user_id] = user.id
    get :edit, params: { id: user }
    assert_response :success
    assert_not_nil assigns(:user)
  end

  test "should not update if not the same user" do
    users = create_list(:user, 2)
    session[:user_id] = users[0].id
    patch :update, params: { id: users[1], user: { disable_comment_emails: 1 } }
    users[1].reload
    assert !users[1].disable_comment_emails
    assert_redirected_to user_path(users[1])
  end

  test "should update" do
    user = create(:user)
    session[:user_id] = user.id
    patch :update, params: { id: user, user: { disable_comment_emails: 1 } }
    assert_redirected_to edit_user_path(user)
    user.reload
    assert user.disable_comment_emails
  end
end
