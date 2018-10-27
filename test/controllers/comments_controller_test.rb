require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  test "should not create comment without login" do
    q = create(:question)
    assert_no_difference('Comment.count') do
      post :create, params: { comment: { text: 'this is a comment', post_id: q.id, post_type: 'Question' } }
    end

    assert_redirected_to login_url
  end

  test "should create comment for question" do
    session[:user_id] = create(:user).id
    q = create(:question)
    assert_difference('Comment.count', 1) do
      post :create, params: { comment: { text: 'this is a comment', post_id: q.id, post_type: 'Question' } }
    end

    assert_redirected_to q
  end

  test "should send emails when comment for question" do
    assert_enqueued_jobs 0
    users = create_list(:user, 4)
    q = create(:question, user: users[0])
    create(:comment, user: users[3], post: q)
    a = create(:answer, user: users[1], question: q)
    create(:comment, user: users[2], post: a)
    create(:comment, user: users[2], post: a)

    session[:user_id] = users[3].id
    post :create, params: { comment: { text: 'this is a comment', post_id: q.id, post_type: 'Question' } }
    assert_enqueued_jobs 3
  end

  test "should create comment for answer" do
    session[:user_id] = create(:user).id
    q = create(:question)
    a = create(:answer, question: q)
    assert_difference('Comment.count', 1) do
      post :create, params: { comment: { text: 'this is a comment', post_id: a.id, post_type: 'Answer' } }
    end

    assert_redirected_to a.question
  end

  test "should send emails when comment for answer" do
    assert_enqueued_jobs 0
    users = create_list(:user, 4)
    q = create(:question, user: users[0])
    create(:comment, user: users[3], post: q)
    a = create(:answer, user: users[1], question: q)
    create(:comment, user: users[2], post: a)
    create(:comment, user: users[2], post: a)

    session[:user_id] = users[3].id
    post :create, params: { comment: { text: 'this is a comment', post_id: a.id, post_type: 'Answer' } }
    assert_enqueued_jobs 3
  end

  test "should not create comment without question or answer" do
    session[:user_id] = create(:user).id
    assert_no_difference('Comment.count') do
      post :create, params: { comment: { text: 'this is a comment' } }
    end
  end

  test "should not delete comment without login" do
    u = create(:user)
    q = create(:question)
    comment = create(:comment, post: q, user: u)
    assert_no_difference('Comment.count') do
      post :destroy, params: { id: comment }
    end
    assert_redirected_to login_url
  end

  test "should delete comment" do
    u = create(:user)
    session[:user_id] = u.id
    q = create(:question)
    comment = create(:comment, post: q, user: u)
    assert_difference('Comment.count', -1) do
      post :destroy, params: { id: comment }
    end
    assert_redirected_to q
  end

  test "should not delete another persons comment" do
    session[:user_id] = create(:user).id
    u = create(:user)
    q = create(:question)
    comment = create(:comment, post: q, user: u)
    assert_no_difference('Comment.count') do
      post :destroy, params: { id: comment }
    end
    assert_redirected_to q
  end

  test "should update comment" do
    u = create(:user)
    session[:user_id] = u.id
    q = create(:question)
    comment = create(:comment, post: q, user: u)
    patch :update, params: { id: comment.id, comment: { text: 'all changed' } }
    comment.reload
    assert_equal comment.text, 'all changed'
    assert_redirected_to q
  end

  test "should not update comment without login" do
    q = create(:question)
    comment = create(:comment, post: q, text: 'MyText')
    patch :update, params: { id: comment.id, comment: { text: 'all changed' } }
    comment.reload
    assert_equal comment.text, 'MyText'
    assert_redirected_to login_url
  end

  test "should not update someone elses comment" do
    session[:user_id] = create(:user).id
    u = create(:user)
    q = create(:question)
    comment = create(:comment, post: q, user: u, text: 'MyText')
    patch :update, params: { id: comment.id, comment: { text: 'all changed' } }
    comment.reload
    assert_equal comment.text, 'MyText'
    assert_redirected_to q
  end
end
