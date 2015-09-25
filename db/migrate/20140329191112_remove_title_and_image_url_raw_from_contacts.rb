class RemoveTitleAndImageUrlRawFromContacts < ActiveRecord::Migration
  def up
    remove_column :contacts, :title
    remove_column :contacts, :image_url_raw
  end

  def down
    add_column :contacts, :title, :string
    add_column :contacts, :image_url_raw, :string
  end
end
