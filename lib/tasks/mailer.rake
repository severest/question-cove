namespace :mailer do
  desc "Send email to users with unanswered questions"
  task :unanswered_reminder => :environment do
    users = User.with_unanswered_questions.where(disable_unanswered_reminder_email: false)
    puts "Now sending reminder email to #{users.count()} users..."
    users.each do |user|
      puts "...#{user.email}"
      NotificationMailer.with(user: user).unanswered_reminder.deliver_later
    end
    puts "DONE"
  end
end
