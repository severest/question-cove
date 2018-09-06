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

  def unanswered_reminder
    user = User.joins(:questions).where(questions: { best_answer_id: nil }).distinct.first
    NotificationMailer.with(
      user: user
    ).unanswered_reminder
  end
end
