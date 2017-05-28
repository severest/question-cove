class AddSlugToQuestions < ActiveRecord::Migration[4.2]
  def change
    add_column :questions, :slug, :string
    add_index :questions, :slug, unique: true
  end
end
