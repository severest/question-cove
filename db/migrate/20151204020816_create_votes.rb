class CreateVotes < ActiveRecord::Migration[4.2]
  def change
    create_table :votes do |t|
      t.integer :vote, default: 0
      t.references :voteable, polymorphic: true, index: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :votes, [:voteable_id, :voteable_type, :user_id], :unique => true
  end
end
