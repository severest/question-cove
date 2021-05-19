class UnansweredQuestionTask
  include Delayed::RecurringJob
  run_every 3.months
  run_at Time.now.utc.beginning_of_year
  timezone 'US/Pacific'
  queue 'mailers'

  def perform
    users = User.with_unanswered_questions.where(disable_unanswered_reminder_email: false)
    users.each do |user|
      NotificationMailer.with(user: user).unanswered_reminder.deliver_later if Rails.application.config.email_notifications
    end
  end
end
