class NotificationMailer < ApplicationMailer
  def new_comment
    @question = params[:question]
    @comment = params[:comment]
    @user = params[:user]
    mail(:to => @user.email, :subject => 'QuestionCove: There is a new comment')
  end

  def unanswered_reminder
    @user = params[:user]
    @questions = @user.questions.where(best_answer_id: nil).limit(15)
    mail(:to => @user.email, :subject => 'QuestionCove: You have unanswered questions')
  end
end
