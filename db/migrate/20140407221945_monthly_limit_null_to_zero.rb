class MonthlyLimitNullToZero < ActiveRecord::Migration
  def change
    change_column :plans, :monthly_limit, :integer, default: 25, null: 0
  end
end
