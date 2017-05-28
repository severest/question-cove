class AnswersController < ApplicationController
  before_action :require_login
  before_action :set_answer, only: [:voteup, :votedown]

  # POST /questions
  # POST /questions.json
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer.question, notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { redirect_to @answer.question, alert: 'There was a problem saving your answer.' }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def voteup
    vote = get_user_vote
    if vote.nil?
      add_vote 1
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
      add_vote -1
    elsif vote.vote != -1
      vote.update(vote: -1)
    end

    respond_to do |format|
      format.html { redirect_to @answer.question }
      format.json { render :show, location: @answer }
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
end
