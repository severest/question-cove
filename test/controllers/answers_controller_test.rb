require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  test "should update answer" do
    session[:user_id] = users(:sean).id
    patch :update, params: { id: answers(:one), answer: { text: 'updated text!' } }
    assert_redirected_to question_path(questions(:one))
  end

  test "should destroy answer" do
    session[:user_id] = users(:sean).id
    assert_difference('Answer.count', -1) do
      delete :destroy, params: { id: answers(:one) }
    end
    assert_redirected_to questions(:one)
  end

  test "should nullify best answer when destoryed" do
    session[:user_id] = users(:sean).id
    q = questions(:two)
    assert_not_nil q.best_answer
    delete :destroy, params: { id: q.best_answer.id }
    q.reload
    assert_nil q.best_answer
  end

  test "should not destroy answer of another user" do
    session[:user_id] = users(:john).id
    assert_no_difference('Answer.count') do
      delete :destroy, params: { id: answers(:one) }
    end
    assert_redirected_to questions(:one)
  end
end
