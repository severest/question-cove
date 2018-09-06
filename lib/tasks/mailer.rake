namespace :mailer do
  desc "Send email to users with unanswered questions"
  task :unanswered_reminder => :environment do
    User.with_unanswered_questions.where(disable_unanswered_reminder_email: false).each do |user|
      NotificationMailer.with(user: user).unanswered_reminder.deliver_later
    end
  end
end
