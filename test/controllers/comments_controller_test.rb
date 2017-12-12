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
    assert_difference('Comment.count', 1) do
      post :create, params: { comment: { text: 'this is a comment', post_id: q.id, post_type: 'Question' } }
    end

    assert_redirected_to question_path(q)
  end

  test "should create comment for answer" do
    session[:user_id] = users(:sean).id
    a = answers(:one)
    assert_difference('Comment.count', 1) do
      post :create, params: { comment: { text: 'this is a comment', post_id: a.id, post_type: 'Answer' } }
    end

    assert_redirected_to question_path(a.question)
  end

  test "should not create comment without question or answer" do
    session[:user_id] = users(:sean).id
    assert_no_difference('Comment.count') do
      post :create, params: { comment: { text: 'this is a comment' } }
    end
  end

  test "should not delete comment without login" do
    assert_no_difference('Comment.count') do
      post :destroy, params: { id: comments(:one) }
    end
    assert_redirected_to login_url
  end

  test "should delete comment" do
    session[:user_id] = users(:sean).id
    assert_difference('Comment.count', -1) do
      post :destroy, params: { id: comments(:one) }
    end
    assert_redirected_to question_path(questions(:one))
  end

  test "should not delete another persons comment" do
    session[:user_id] = users(:sean).id
    assert_no_difference('Comment.count') do
      post :destroy, params: { id: comments(:two) }
    end
    assert_redirected_to question_path(questions(:two))
  end

  test "should update comment" do
    session[:user_id] = users(:sean).id
    comment = comments(:one)
    patch :update, params: { id: comment.id, comment: { text: 'all changed' } }
    comment.reload
    assert_equal comment.text, 'all changed'
    assert_redirected_to question_path(questions(:one))
  end

  test "should not update comment without login" do
    comment = comments(:one)
    patch :update, params: { id: comment.id, comment: { text: 'all changed' } }
    comment.reload
    assert_equal comment.text, 'MyText'
    assert_redirected_to login_url
  end

  test "should not update someone elses comment" do
    session[:user_id] = users(:sean).id
    comment = comments(:two)
    patch :update, params: { id: comment.id, comment: { text: 'all changed' } }
    comment.reload
    assert_equal comment.text, 'MyText'
    assert_redirected_to question_path(questions(:two))
  end
end
