class RenameAccountToApp < ActiveRecord::Migration
  def self.up
    rename_table :accounts, :apps
  end
  def self.down
    rename_table :apps, :accounts
  end
end
