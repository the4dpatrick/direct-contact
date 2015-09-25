class CreateDemographics < ActiveRecord::Migration
  def change
    create_table :demographics do |t|
      t.integer :contact_id
      t.string :gender
      t.string :age
      t.string :location_general
      t.string :age_range

      t.timestamps
    end
  end
end
