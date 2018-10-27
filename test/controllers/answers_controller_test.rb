require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  setup do
    @user1 = create(:user)
    @user2 = create(:user)
    @question = create(:question)
    @answer = create(:answer, user: @user1, question: @question)
    create(:vote, voteable: @answer, vote: 1)
    create(:vote, voteable: @answer, vote: 1)
    create(:vote, voteable: @answer, vote: -1)
  end

  test "should not create answer without login" do
    question = create(:question)
    assert_no_difference('Answer.count') do
      post :create, params: { answer: { text: 'an answer', question_id: question.id } }
    end

    assert_redirected_to login_url
  end

  test "should create answer" do
    session[:user_id] = @user1.id
    question = create(:question)
    assert_difference('Answer.count') do
      post :create, params: { answer: { text: 'an answer', question_id: question.id } }
    end

    assert_redirected_to question_path(question)
  end

  test "should not create answer without question" do
    session[:user_id] = @user1.id
    assert_no_difference('Answer.count') do
      post :create, params: { answer: { text: 'an answer' } }
    end
  end

  test "should update answer" do
    session[:user_id] = @user1.id
    patch :update, params: { id: @answer.id, answer: { text: 'updated text!' } }
    assert_redirected_to @question
  end

  test "should destroy answer" do
    session[:user_id] = @user1.id
    assert_difference('Answer.count', -1) do
      delete :destroy, params: { id: @answer }
    end
    assert_redirected_to @question
  end

  test "should nullify best answer when destoryed" do
    session[:user_id] = @user1.id
    q = create(:question)
    q.best_answer = create(:answer, question: q, user: @user1)
    q.save
    q.reload
    assert_not_nil q.best_answer
    delete :destroy, params: { id: q.best_answer.id }
    q.reload
    assert_nil q.best_answer
  end

  test "should not destroy answer of another user" do
    session[:user_id] = @user2.id
    assert_no_difference('Answer.count') do
      delete :destroy, params: { id: @answer }
    end
    assert_redirected_to @question
  end

  test "should get edit" do
    session[:user_id] = @user1.id
    get :edit, params: { id: @answer }
    assert_response :success
  end

  test "should not get edit for not your answer" do
    session[:user_id] = @user2.id
    get :edit, params: { id: @answer }
    assert_redirected_to @question
  end

  test "should update question" do
    session[:user_id] = @user1.id
    patch :update, params: { id: @answer, answer: { text: 'changed my answer' } }
    @answer.reload
    assert_equal @answer.text, 'changed my answer'
    assert_redirected_to @answer.question
  end

  test "should not update question" do
    session[:user_id] = @user2.id
    patch :update, params: { id: @answer, answer: { text: 'changed my answer' } }
    @answer.reload
    assert_not_equal @answer.text, 'changed my answer'
    assert_redirected_to @answer.question
  end

  test "should vote up" do
    session[:user_id] = @user1.id
    assert_equal @answer.total_votes, 1
    post :voteup, params: { id: @answer.id }
    @answer.reload
    assert_equal @answer.total_votes, 2
    post :voteup, params: { id: @answer.id }
    @answer.reload
    assert_equal @answer.total_votes, 2
  end

  test "should vote down" do
    session[:user_id] = @user1.id
    assert_equal @answer.total_votes, 1
    post :votedown, params: { id: @answer.id }
    @answer.reload
    assert_equal @answer.total_votes, 0
    post :votedown, params: { id: @answer.id }
    @answer.reload
    assert_equal @answer.total_votes, 0
  end
end
