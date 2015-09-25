class AddAttributesToContacts < ActiveRecord::Migration
  def up
    add_column :contacts, :name, :string
    add_column :contacts, :twitter_username, :string
    add_column :contacts, :location, :string
    add_column :contacts, :headline, :string
    add_column :contacts, :images, :text
    add_column :contacts, :phones, :text
    add_column :contacts, :occupations, :text
    add_column :contacts, :memberships, :text
    add_column :contacts, :gravatar_image_url_raw, :string
  end

  def down
    remove_column :contacts, :name
    remove_column :contacts, :twitter_username
    remove_column :contacts, :location
    remove_column :contacts, :headline
    remove_column :contacts, :images
    remove_column :contacts, :phones
    remove_column :contacts, :occupations
    remove_column :contacts, :memberships
    remove_column :contacts, :gravatar_image_url_raw
  end
end
