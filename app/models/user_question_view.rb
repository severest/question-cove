class UserQuestionView < ApplicationRecord
  belongs_to :user
  belongs_to :question

  def rails_admin_label
    "#{user.name} views Question ##{question.id}"
  end
end
