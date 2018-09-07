set :output, "log/whenever.log"

every 3.months do
  rake "mailer:unanswered_reminder"
end
