class AddTitleToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :title, :string
  end
end
