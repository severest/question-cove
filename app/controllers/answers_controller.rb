class AnswersController < ApplicationController
  before_action :require_login
  before_action :set_answer, only: [:voteup, :votedown, :edit, :update, :destroy]
  before_action :can_edit_redirect, only: [:edit, :update, :destroy]

  # POST /questions
  # POST /questions.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        if Rails.application.config.slack_notifications
          SlackNotifierJob.perform_later("The experts have responded: *#{@answer.question.first_line_for_slug.strip}* #{question_url(@answer.question)}")
        end

        format.html { redirect_to @answer.question, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { redirect_to root_path, alert: 'There was a problem saving your answer.' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def voteup
    vote = get_user_vote
    if vote.nil?
      add_vote(1)
    elsif vote.vote != 1
      vote.update(vote: 1)
    end

    respond_to do |format|
      format.html { redirect_to @answer.question }
      format.json { render :show, location: @answer }
    end
  end

  def votedown
    vote = get_user_vote
    if vote.nil?
      add_vote(-1)
    elsif vote.vote != -1
      vote.update(vote: -1)
    end

    respond_to do |format|
      format.html { redirect_to @answer.question }
      format.json { render :show, location: @answer }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer.question, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer.question }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    question = @answer.question
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to question, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:text, :votes, :question_id)
    end

    def set_answer
      @answer = Answer.find(params[:id])
    end

    def get_user_vote
      @answer.votes.where(user_id: current_user.id).first
    end

    def add_vote(value)
      vote =  Vote.new
      vote.user = current_user
      vote.vote = value
      @answer.votes.push(vote)
    end

    def can_edit_answer
      @answer.user == current_user
    end

    def can_edit_redirect
      redirect_to @answer.question unless can_edit_answer
    end
end
