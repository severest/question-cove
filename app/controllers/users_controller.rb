class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [:show, :edit, :update]
  before_action :can_edit_redirect, only: [:edit, :update]
  helper_method :can_edit_user

  def show
    @type = params[:type] || 'questions'
    @order = 'created_at'
    if params[:order] == 'views'
      @order = 'views'
    elsif params[:order] == 'total_votes'
      @order = 'total_votes'
    end

    if @type == 'questions'
      @questions = @user.questions.order(@order + ' DESC').page(params[:page])
    else
      @questions = Question.joins(:answers).where('answers.user_id' => @user.id).distinct.order(@order + ' DESC').page(params[:page])
    end

    @most_used_tags = @user.questions.tag_counts_on(:tags, order: 'count desc', limit: 10)
    @total_tags = @user.questions.all_tags.sum(:taggings_count)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: 'User was successfully updated.'
    else
      redirect_to edit_user_path(@user)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    def can_edit_user
      @user == current_user
    end

    def can_edit_redirect
      redirect_to user_path(@user) unless can_edit_user
    end

    def user_params
      params.require(:user).permit(:disable_comment_emails)
    end
end
