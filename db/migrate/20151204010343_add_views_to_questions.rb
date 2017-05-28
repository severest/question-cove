class AddViewsToQuestions < ActiveRecord::Migration[4.2]
  def change
    add_column :questions, :views, :integer, default: 0
  end
end
