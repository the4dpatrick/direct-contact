class RenameRolesToPlan < ActiveRecord::Migration
  def change
    rename_table :roles, :plans
  end
end
