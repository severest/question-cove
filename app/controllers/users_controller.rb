class UsersController < LoggedinController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :can_edit_redirect, only: [:edit, :update]
  helper_method :can_edit_user

  def show
    @type = params[:type] || 'questions'

    if @type == 'questions'
      @questions = @user.questions.get_ordered_questions(params[:order], params[:page])
    else
      @questions = Question.joins(:answers).where('answers.user_id' => @user.id).distinct.get_ordered_questions(params[:order], params[:page])
    end

    @most_used_tags = @user.questions.tag_counts_on(:tags, order: 'taggings_count desc', limit: 5)
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
      params.require(:user).permit(:disable_comment_emails, :disable_unanswered_reminder_email)
    end
end
