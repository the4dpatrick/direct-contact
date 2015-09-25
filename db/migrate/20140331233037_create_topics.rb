class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :digital_footprint_id
      t.string :provider
      t.string :value

      t.timestamps
    end
  end
end
