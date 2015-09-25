class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :contact_id
      t.string :client
      t.string :handle

      t.timestamps
    end
  end
end
