class AddFoundEmailsCountThisCycleToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :found_emails_count
    add_column :users, :found_emails_count_this_cycle, :integer
  end
end
