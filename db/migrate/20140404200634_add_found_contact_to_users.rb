class AddFoundContactToUsers < ActiveRecord::Migration
  def change
    add_column :users, :found_count, :integer, default: 0
  end
end
