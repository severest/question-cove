require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test "total vote count" do
    question = create(:question)
    answer = create(:answer, question: question)
    create(:vote, voteable: answer, vote: 1)
    create(:vote, voteable: answer, vote: 1)
    create(:vote, voteable: answer, vote: -1)
    assert_equal 1, answer.total_votes
  end

  test "markdown render" do
    question = create(:question)
    answer = create(:answer, question: question, text: "*bold answer* and a <http://test.net>")
    assert_equal "<p><em>bold answer</em> and a <a href=\"http://test.net\">http://test.net</a></p>\n", answer.render_answer
  end
end
