require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should not save without text" do
    c = Comment.new
    c.user = create(:user)
    c.post = create(:question)
    assert_not c.save()
  end
end
