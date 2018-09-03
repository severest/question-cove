require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "should have first line" do
    q = Question.create(text: '# This is my title')
    assert_equal q.first_line, '<h1>This is my title</h1>
'
    assert_equal q.first_line_for_slug, ' This is my title'
  end

  test "should return sorted answers" do
    q = questions(:two)
    assert_equal q.sorted_answers[0].id, answers(:three).id
  end

  test "should return all participating users" do
    users = create_list(:user, 4)
    q = create(:question, user: users[0])
    create(:comment, user: users[3], post: q)
    a = create(:answer, user: users[1], question: q)
    create(:comment, user: users[2], post: a)
    create(:comment, user: users[2], post: a)
    assert_equal users.pluck('id'), q.all_users_involved.pluck(:id)
  end
end
