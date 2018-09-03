class NotificationMailer < ApplicationMailer
  def new_comment
    @question = params[:question]
    @comment = params[:comment]
    @user = params[:user]
    mail(:to => @user.email, :subject => 'QuestionCove: There is a new comment')
  end
end
