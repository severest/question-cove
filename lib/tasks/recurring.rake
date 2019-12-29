namespace :recurring do
  task :init => :environment do
    UnansweredQuestionTask.schedule!
  end
end
