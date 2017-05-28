class AddVotesToQuestions < ActiveRecord::Migration[4.2]
  def change
    add_column :questions, :total_votes, :integer, default: 0
  end
end
