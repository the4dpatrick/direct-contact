class CreateDigitalFootprints < ActiveRecord::Migration
  def change
    create_table :digital_footprints do |t|
      t.integer :contact_id

      t.timestamps
    end
  end
end
