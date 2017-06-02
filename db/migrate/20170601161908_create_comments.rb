class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :user, index: true, foreign_key: true
      t.references :post, polymorphic: true, index: true

      t.timestamps
    end
  end
end
