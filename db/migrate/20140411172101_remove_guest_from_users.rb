class RemoveGuestFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :guest
  end
end
