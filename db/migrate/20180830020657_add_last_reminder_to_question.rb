class AddLastReminderToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :last_reminder, :datetime
  end
end
