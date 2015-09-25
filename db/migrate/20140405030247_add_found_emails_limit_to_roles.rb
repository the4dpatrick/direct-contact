class AddFoundEmailsLimitToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :found_emails_limit, :integer, default: 125
  end
end
