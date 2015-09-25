class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :digital_footprint_id
      t.string :provider
      t.string :type
      t.integer :value

      t.timestamps
    end
  end
end
