class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :best_answer, :voteup, :votedown]
  before_filter :can_edit_redirect, only: [:edit, :update, :destroy, :best_answer]
  helper_method :can_edit_question

  # GET /questions
  # GET /questions.json
  def index
    @order = params[:order] || 'created_at'
    if params[:s].nil?
      @questions = Question.order(@order + ' DESC').page(params[:page])
    else
      @search_query = params[:s]
      @questions = Question.where("match(text) against (?)", @search_query).union(Question.tagged_with(@search_query)).order(@order + ' DESC').page(params[:page])
    end
    @most_used_tags = ActsAsTaggableOn::Tag.most_used(10)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @answer = Answer.new
    @answer.question = @question
    @question.update(views: @question.views+1)
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.text = Question.starting_text
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        flash[:alert] = 'There was a problem saving your question.'
        format.html { render :new  }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_tags_like
    if params[:s].nil? || params[:s] == ""
      render json: []
    else
      tag_list = ActsAsTaggableOn::Tag.named_like(params[:s])
      tag_list.push({:name => params[:s]}) unless tag_list.count > 0
      render json: tag_list
    end
  end

  def best_answer
    answer = Answer.find(params[:answer_id])
    if answer.question.id != @question.id
      redirect_to @question, alert: 'There was a problem setting the best answer'
    else
      @question.best_answer = answer
      respond_to do |format|
        if @question.save
          format.html { redirect_to @question, notice: 'Best answer was set' }
          format.json { render :show, status: :created, location: @question }
        else
          flash[:alert] = 'There was a problem saving your question.'
          format.html { redirect_to @question  }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def voteup
    vote = get_user_vote
    if vote.nil?
      add_vote 1
      @question.update(total_votes: @question.calculate_votes)
    elsif vote.vote != 1
      vote.update(vote: 1)
      @question.update(total_votes: @question.calculate_votes)
    end

    respond_to do |format|
      format.html { redirect_to @question }
      format.json { render :show, location: @question }
    end
  end

  def votedown
    vote = get_user_vote
    if vote.nil?
      add_vote -1
      @question.update(total_votes: @question.calculate_votes)
    elsif vote.vote != -1
      vote.update(vote: -1)
      @question.update(total_votes: @question.calculate_votes)
    end

    respond_to do |format|
      format.html { redirect_to @question }
      format.json { render :show, location: @question }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:text, :tag_list)
    end

    def can_edit_question
      @question.user == current_user || current_user.admin
    end

    def can_edit_redirect
      redirect_to root_path unless can_edit_question
    end

    def get_user_vote
      @question.votes.where(user_id: current_user.id).first
    end

    def add_vote(value)
      vote =  Vote.new
      vote.user = current_user
      vote.vote = value
      @question.votes.push(vote)
    end
end
