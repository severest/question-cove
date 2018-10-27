require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @user1 = create(:user)
    @user2 = create(:user)
    @question = create(:question, user: @user1)
    answer = create(:answer, question: @question)
    create(:vote, voteable: answer, vote: 1)
    create(:vote, voteable: answer, vote: 1)
    create(:vote, voteable: answer, vote: -1)
  end

  test "should not get index without login" do
    get :index
    assert_redirected_to login_url
  end

  test "should get index" do
    session[:user_id] = @user1.id
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should get new" do
    session[:user_id] = @user1.id
    get :new
    assert_response :success
  end

  test "should not create question without login" do
    assert_no_difference('Question.count') do
      post :create, params: { question: { text: @question.text } }
    end

    assert_redirected_to login_url
  end

  test "should create question" do
    session[:user_id] = @user1.id
    assert_difference('Question.count') do
      post :create, params: { question: { text: @question.text } }
    end

    assert_redirected_to question_path(assigns(:question))
  end

  test "should show question" do
    session[:user_id] = @user1.id
    get :show, params: { id: @question }
    assert_response :success
  end

  test "should get edit" do
    session[:user_id] = @user1.id
    get :edit, params: { id: @question }
    assert_response :success
  end

  test "should not get edit with wrong user" do
    session[:user_id] = @user2.id
    get :edit, params: { id: @question }
    assert_redirected_to root_path
  end

  test "should update question" do
    session[:user_id] = @user1.id
    patch :update, params: { id: @question, question: { text: @question.text } }
    assert_redirected_to question_path(assigns(:question))
  end

  test "should not update question with wrong user" do
    session[:user_id] = @user2.id
    patch :update, params: { id: @question, question: { text: @question.text } }
    assert_redirected_to root_path
  end

  test "should destroy question" do
    session[:user_id] = @user1.id
    assert_difference('Question.count', -1) do
      delete :destroy, params: { id: @question }
    end

    assert_redirected_to questions_path
  end

  test "should not destroy question with wrong user" do
    session[:user_id] = @user2.id
    assert_no_difference('Question.count') do
      delete :destroy, params: { id: @question }
    end

    assert_redirected_to root_path
  end
end
