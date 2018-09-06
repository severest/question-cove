namespace :db do
  desc "Transfer question views from a number to new table"
  task :migrate_views => :environment do
    Question.all.each do |question|
      (1..question.views).each do |view|
        UserQuestionView.create(question: question)
      end
    end
  end
end
