class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :votes, as: :voteable, dependent: :destroy
  has_many :comments, as: :post, dependent: :destroy
  has_one :best_answer_question, class_name: "Question", foreign_key: "best_answer_id", dependent: :nullify

  validates :text, presence: true
  validates :question, presence: true

  def total_votes
    count = 0
    self.votes.each do |v|
      count = count + v.vote
    end
    return count
  end

  def render_answer
    @@markdown.render(self.text)
  end

  def rails_admin_label
    "#{user.name} answers Question ##{question.id}"
  end
end
