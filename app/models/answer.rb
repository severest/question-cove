class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :votes, as: :voteable, dependent: :destroy
  has_many :comments, as: :post, dependent: :destroy

  validates :text, presence: true

  @@markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)

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
end
