class CreateUserQuestionViews < ActiveRecord::Migration[5.2]
  def change
    create_table :user_question_views do |t|
      t.references :user, type: :integer, foreign_key: true
      t.references :question, type: :integer, foreign_key: true

      t.timestamps
    end
  end
end
