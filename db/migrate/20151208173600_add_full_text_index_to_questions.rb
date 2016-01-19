class AddFullTextIndexToQuestions < ActiveRecord::Migration
  def change
    add_index(:questions, :text, type: :fulltext)
  end
end
