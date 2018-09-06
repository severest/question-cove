class User < ApplicationRecord
  extend FriendlyId
  friendly_id :email, use: :slugged
  has_many :questions
  has_many :answers
  has_many :question_views, class_name: "UserQuestionView"

  def self.from_omniauth(auth_hash)
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.save!
    user
  end

  def self.with_unanswered_questions
    self.joins(:questions)
      .where(questions: { best_answer_id: nil })
      .distinct
  end
end
