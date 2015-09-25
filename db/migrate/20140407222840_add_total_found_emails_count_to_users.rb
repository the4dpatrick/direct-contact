class AddTotalFoundEmailsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_found_emails_count, :integer
  end
end
