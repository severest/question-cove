class AddDisableUnansweredReminderEmailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :disable_unanswered_reminder_email, :boolean
  end
end
