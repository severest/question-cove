# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview
  def new_comment
    user = User.first
    NotificationMailer.with(
      question: Question.first,
      comment: Comment.new(text: 'this is a comment', user: user),
      user: user
    ).new_comment
  end
end
