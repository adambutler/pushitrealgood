class AddUidToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :uid, :string
  end
end
