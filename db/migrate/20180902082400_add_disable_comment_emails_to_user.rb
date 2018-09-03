class AddDisableCommentEmailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :disable_comment_emails, :boolean, default: false
  end
end
