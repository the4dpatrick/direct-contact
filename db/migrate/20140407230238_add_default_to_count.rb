class AddDefaultToCount < ActiveRecord::Migration
  def change
    change_column :users, :total_found_emails_count, :integer, default: 0
    change_column :users, :found_emails_count_this_cycle, :integer, default: 0
  end
end
