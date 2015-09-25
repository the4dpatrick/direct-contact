class PlanHasManyUsers < ActiveRecord::Migration
  def change
    remove_column :plans, :user_id
    add_column :users, :plan_id, :integer
  end
end
