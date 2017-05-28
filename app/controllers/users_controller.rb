class UsersController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [:show]

  def show
    @order = params[:order] || 'created_at'
    @type = params[:type] || 'questions'

    if @type == 'questions'
      @questions = @user.questions.order(@order + ' DESC').page(params[:page])
    else
      @questions = Question.joins(:answers).where('answers.user_id' => @user.id).distinct.order(@order + ' DESC').page(params[:page])
    end

    @most_used_tags = @user.questions.tag_counts_on(:tags, order: 'count desc', limit: 10)
    @total_tags = @user.questions.all_tags.sum(:taggings_count)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end
end
