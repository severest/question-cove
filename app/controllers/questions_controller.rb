class QuestionsController < LoggedinController
  before_action :set_question, except: [:index, :new, :create, :get_tags_like, :show]
  before_action :can_edit_redirect, only: [:edit, :update, :destroy, :best_answer, :remind_on_slack]
  helper_method :can_edit_question

  # GET /questions
  # GET /questions.json
  def index
    @search_query = params[:s]
    @questions = Question.get_ordered_questions(params[:order], params[:page], @search_query)
    # @most_used_tags = ActsAsTaggableOn::Tag.most_used(10)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.friendly.includes({answers: {comments: [:user]}}, {comments: [:user]}).find(params[:id])
    @answer = Answer.new
    @answer.question = @question
    @question.increment_view(current_user)
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
    @question = Question.new(text: question_params['text'])
    set_tags
    @question.user = current_user

    respond_to do |format|
      if @question.save
        if Rails.application.config.slack_notifications
          SlackNotifierJob.perform_later("A new question has been asked: *#{@question.first_line_for_slug.strip}* #{question_url(@question)}")
        end

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
      if tag_list.count > 0
        render json: tag_list
      else
        render json: [{:name => params[:s]}]
      end
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
          format.json { render :show, status: :ok, location: @question }
        else
          flash[:alert] = 'There was a problem saving your question.'
          format.html { redirect_to @question  }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def remind_on_slack
    if Rails.application.config.slack_notifications
      t = @question.last_reminder.nil? ? @question.created_at : @question.last_reminder
      if t < Time.now - 1.hour
        SlackNotifierJob.perform_later("The question still requires a solution, please help if you can: *#{@question.first_line_for_slug.strip}* #{question_url(@question)}")
        notice = 'A reminder has been sent'
        @question.last_reminder = Time.now
        @question.save
      else
        notice = 'You can only remind slack once an hour'
      end
    else
      notice = 'Slack notifications are disabled'
    end

    respond_to do |format|
      format.html { redirect_to @question, notice: notice }
      format.json { render :show, status: :ok, location: @question }
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      @question.text = question_params['text']
      set_tags
      if @question.save
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
      add_vote(1)
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
      add_vote(-1)
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
      @question.user == current_user
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

    def set_tags
      tag_list = ""
      if !question_params['tag_list'].nil?
        tag_list = question_params['tag_list']
      end
      new_tags = tag_list.split(',').reject { |c| c.empty? }
      old_tags = @question.tags.map(&:name)
      return if new_tags == old_tags
      (old_tags - new_tags).map {|e| @question.tag_list.remove(e)}
      (new_tags - old_tags ).map {|e| @question.tag_list.add e}
    end
end
