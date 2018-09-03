require 'test_helper'

class NotificationMailerTest < ActionMailer::TestCase
  test "new comment" do
    u = create(:user)
    q = create(:question, user: u)
    c = create(:comment, user: u, post: q)

    email = NotificationMailer.with(comment: c, question: q, user: u).new_comment
    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['no-reply@test.com'], email.from
    assert_equal [u.email], email.to
    assert_equal 'QuestionCove: There is a new comment', email.subject
  end
end
