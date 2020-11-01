class Question < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :first_line_for_slug,
      [:id, :first_line_for_slug]
    ]
  end

  has_many :answers, dependent: :destroy
  has_many :votes, as: :voteable, dependent: :destroy
  belongs_to :best_answer, class_name: "Answer", foreign_key: "best_answer_id", optional: true
  belongs_to :user
  has_many :comments, as: :post, dependent: :destroy
  has_many :user_views, class_name: "UserQuestionView", dependent: :destroy

  acts_as_taggable

  validates :text, presence: true

  def render_question
    @@markdown.render(self.text)
  end

  def first_line
    l = @@markdown.render(self.text.lines.first)
    if l.empty?
      return '<h1>No title</h1>'
    else
      return l
    end
  end

  def first_line_for_slug
    str = self.text.lines.first.slice(0,100).delete '#'
    return str
  end

  def rails_admin_label
    self.first_line_for_slug
  end

  def self.starting_text
    %{# Question title

Enter the details of your question here. Feel free to make use of
markdown syntax if you are familiar with it. Use the preview tab
above to see what it will look like.}
  end

  def self.get_ordered_questions(order, page = 1, search_query = nil)
    case order
    when 'views'
      filtered_order = 'views'
    when 'votes'
      filtered_order = 'total_votes'
    when 'unanswered'
      filtered_order = 'unanswered'
    else
      filtered_order = 'created_at'
    end

    qs = self
    if !search_query.nil? and search_query != ''
      qs = where("match(text) against (?)", search_query)
                     .union(Question.tagged_with(search_query))
    end

    if filtered_order == 'views'
      return qs.left_joins(:user_views).group(:id).order(Arel.sql('COUNT(user_question_views.id) desc')).page(page)
    elsif filtered_order == 'unanswered'
      return qs.order('best_answer_id').page(page)
    else
      return qs.order(filtered_order + ' DESC').page(page)
    end
  end

  def sorted_answers
    sorted = self.answers.sort_by { |a| [-a.total_votes] }
    if !self.best_answer.nil?
      with_best = []
      sorted.each do |a|
        with_best.push(a) unless a.id == self.best_answer.id
      end
      with_best.unshift(self.best_answer)
      sorted = with_best
    end
    return sorted
  end

  def calculate_votes
    self.votes.sum(:vote)
  end

  def all_users_involved
    answers = self.answers.includes(:user, {comments: [:user]})
    user_ids = answers.pluck('users.id')
    user_ids.push(answers.pluck('users_comments.id'))
    user_ids.push(self.comments.includes(:user).pluck('users.id'))
    user_ids.push(self.user.id)
    return User.where(id: user_ids.flatten.to_set)
  end

  def increment_view(user)
    last_visit = self.user_views.where(user: user).first()
    if last_visit.nil? or last_visit.created_at < Time.now - 15.minutes
      self.user_views.create(user: user)
    end
  end
end
