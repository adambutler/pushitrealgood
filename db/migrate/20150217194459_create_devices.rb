class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :account_id
      t.string :token

      t.timestamps null: false
    end
  end
end
