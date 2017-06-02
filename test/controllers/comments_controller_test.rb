require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "should not create comment without login" do
    q = questions(:one)
    assert_no_difference('Comment.count') do
      post :create, params: { comment: { text: 'this is a comment', post_id: q.id, post_type: 'Question' } }
    end

    assert_redirected_to login_url
  end

  test "should create comment for question" do
    session[:user_id] = users(:sean).id
    q = questions(:one)
    assert_difference('Comment.count') do
      post :create, params: { comment: { text: 'this is a comment', post_id: q.id, post_type: 'Question' } }
    end

    assert_redirected_to question_path(q)
  end

  test "should create comment for answer" do
    session[:user_id] = users(:sean).id
    a = answers(:one)
    assert_difference('Comment.count') do
      post :create, params: { comment: { text: 'this is a comment', post_id: a.id, post_type: 'Answer' } }
    end

    assert_redirected_to question_path(a.question)
  end
end
