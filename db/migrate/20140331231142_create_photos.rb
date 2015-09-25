class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :contact_id
      t.string :type
      t.string :type_name
      t.string :url
      t.boolean :is_primary, default: false

      t.timestamps
    end
  end
end
