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
  belongs_to :best_answer, class_name: "Answer", foreign_key: "best_answer_id"
  belongs_to :user

  acts_as_taggable

  validates :text, presence: true

  @@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)

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
    return self.text.lines.first.slice(0,100).gsub! '#', ''
  end

  def self.starting_text
    %{# Question title

Enter the details of your question here. Feel free to make use of
markdown syntax if you are familiar with it. Your content will be displayed
to other users as shown in the preview to the right.}
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
end
