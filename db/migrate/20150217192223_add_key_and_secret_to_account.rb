class AddKeyAndSecretToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :key, :string
    add_column :accounts, :secret, :string
  end
end
