class AddApnCerificateToApp < ActiveRecord::Migration
  def change
    add_column :apps, :apn_certificate, :text
  end
end
