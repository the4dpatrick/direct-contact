class CreateSocialProfiles < ActiveRecord::Migration
  def change
    create_table :social_profiles do |t|
      t.integer :contact_id
      t.string :type
      t.string :type_name
      t.string :username
      t.string :url
      t.string :account_id
      t.text :bio
      t.integer :followers
      t.integer :following

      t.timestamps
    end
  end
end
