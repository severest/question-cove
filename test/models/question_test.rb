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
end
