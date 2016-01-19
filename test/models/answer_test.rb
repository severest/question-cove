require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test "total vote count" do
    assert_equal 1, answers(:one).total_votes
  end

  test "markdown render" do
    assert_equal "<p><em>bold answer</em> and a <a href=\"http://test.net\">http://test.net</a></p>\n", answers(:one).render_answer
  end
end
