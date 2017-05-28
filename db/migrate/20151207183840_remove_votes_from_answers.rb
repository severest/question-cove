class RemoveVotesFromAnswers < ActiveRecord::Migration[4.2]
  def change
    remove_column :answers, :votes, :integer
  end
end
