class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :blurb, :string
    add_column :users, :featured, :boolean
    add_column :users, :photo_id, :integer
    add_column :users, :score, :integer
    add_column :users, :price_min, :integer
    add_column :users, :price_max, :integer
  end
end
