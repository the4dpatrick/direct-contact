class RenameFoundCountToFoundEmailsCount < ActiveRecord::Migration
  def change
    rename_column :users, :found_count, :found_emails_count
  end
end
