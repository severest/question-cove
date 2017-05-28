class AddFullTextIndexToQuestions < ActiveRecord::Migration[4.2]
  def change
    add_index(:questions, :text, type: :fulltext)
  end
end
