class AddVotesToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :total_votes, :integer, default: 0
  end
end
