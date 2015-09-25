class RenameTypeToNetworkType < ActiveRecord::Migration
  def change
    rename_column :photos, :type, :network_type
    rename_column :scores, :type, :network_type
    rename_column :social_profiles, :type, :network_type
  end
end
