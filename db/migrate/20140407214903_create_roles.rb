class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :user_id
      t.integer :monthly_limit
      t.string :name
      t.decimal :price
    end
  end
end
