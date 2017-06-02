class CommentsController < ApplicationController
  before_action :require_login

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    if @comment.save
      if @comment.post.class.name == "Question"
        redirect_to @comment.post, notice: 'Comment was successfully created.'
      else
        redirect_to @comment.post.question, notice: 'Comment was successfully created.'
      end
    else
      render :new
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:text, :post_id, :post_type)
    end
end
