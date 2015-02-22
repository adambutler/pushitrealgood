class RenameAccountIdToAppIdInDevices < ActiveRecord::Migration
  def self.up
    rename_column :devices, :account_id, :app_id
  end

  def self.down
    rename_column :devices, :app_id, :account_id
  end
end
