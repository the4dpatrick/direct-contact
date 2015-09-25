class AddImageUrlRawToContacts < ActiveRecord::Migration
  def up
    remove_column :contacts, :gravatar_image_url_raw
    add_column :contacts, :image_url_raw, :string
  end

  def down
    add_column :contacts, :gravatar_image_url_raw, :string
    remove_column :contacts, :image_url_raw
  end
end
