class AddAttemptsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :search_attempts_this_cycle, :integer, default: 0
    add_column :users, :total_search_attempts, :integer, default: 0
  end
end
