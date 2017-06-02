require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "should not save without text" do
    c = Comment.new
    c.user = users(:sean)
    c.post = questions(:one)
    assert_not c.save()
  end
end
