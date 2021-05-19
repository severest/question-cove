class CommentsController < LoggedinController
  before_action :set_question, only: [:destroy, :update]

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      if @comment.post_type == 'Question'
        question = @comment.post
      else
        question = @comment.post.question
      end

      users_to_email = question.all_users_involved.where(disable_comment_emails: false)
                         .select { |user| user != @comment.user }
      users_to_email.each do |user|
        NotificationMailer.with(comment: @comment, question: question, user: user).new_comment.deliver_later if Rails.application.config.email_notifications
      end

      redirect_to get_redirect_url(@comment), notice: 'Comment was successfully created.'
    else
      flash[:alert] = 'There was a problem creating your comment.'
      redirect_to root_url
    end
  end

  def update
    url = get_redirect_url(@comment)
    if current_user == @comment.user and @comment.update(comment_params)
      redirect_to url, notice: 'Comment was successfully updated.'
    else
      flash[:alert] = 'Updating comment failed.'
      redirect_to url
    end
  end

  def destroy
    url = get_redirect_url(@comment)
    if current_user != @comment.user
      flash[:alert] = 'You cannot delete someone elses comment.'
      redirect_to url
    else
      question = @comment.post
      @comment.destroy
      redirect_to url, notice: 'Comment was successfully destroyed.'
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:text, :post_id, :post_type)
    end

    def set_question
      @comment = Comment.find(params[:id])
    end

    def get_redirect_url(comment)
      if comment.post.class.name == "Question"
        return comment.post
      elsif comment.post.class.name == "Answer"
        return comment.post.question
      else
        return root_path
      end
    end
end
