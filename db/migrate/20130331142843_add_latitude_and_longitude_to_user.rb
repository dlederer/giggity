class AddLatitudeAndLongitudeToUser < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :address_longitude, :float
    add_column :users, :address_latitude, :float
  end
end
