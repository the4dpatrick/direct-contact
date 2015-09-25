class ChangeFoundEmailsLimitOnRoles < ActiveRecord::Migration
  def change
    change_column :roles, :found_emails_limit, :integer, default: 25
  end
end
