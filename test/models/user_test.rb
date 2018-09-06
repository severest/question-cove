require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "users with unanswered" do
    users = create_list(:user, 5)
    create(:question, user: users[0])
    create(:question, user: users[0])
    create(:question, user: users[1])
    q = create(:question, user: users[2])
    a = create(:answer, question: q, user: users[3])
    q.best_answer = a
    q.save()
    assert_equal 3, User.with_unanswered_questions.count()
  end
end
