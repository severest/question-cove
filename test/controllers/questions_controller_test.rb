require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase
  setup do
    @question = questions(:one)
  end

  test "should not get index without login" do
    get :index
    assert_redirected_to login_url
  end

  test "should get index" do
    session[:user_id] = users(:sean).id
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should get new" do
    session[:user_id] = users(:sean).id
    get :new
    assert_response :success
  end

  test "should create question" do
    session[:user_id] = users(:sean).id
    assert_difference('Question.count') do
      post :create, params: { question: { text: @question.text } }
    end

    assert_redirected_to question_path(assigns(:question))
  end

  test "should show question" do
    session[:user_id] = users(:sean).id
    get :show, params: { id: @question }
    assert_response :success
  end

  test "should get edit" do
    session[:user_id] = users(:sean).id
    get :edit, params: { id: @question }
    assert_response :success
  end

  test "should update question" do
    session[:user_id] = users(:sean).id
    patch :update, params: { id: @question, question: { text: @question.text } }
    assert_redirected_to question_path(assigns(:question))
  end

  test "should destroy question" do
    session[:user_id] = users(:sean).id
    assert_difference('Question.count', -1) do
      delete :destroy, params: { id: @question }
    end

    assert_redirected_to questions_path
  end
end
