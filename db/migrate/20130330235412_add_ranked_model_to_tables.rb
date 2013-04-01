class AddRankedModelToTables < ActiveRecord::Migration
  def change
    add_column :songs, :row_order, :integer
    add_column :videos, :row_order, :integer
    add_column :photos, :row_order, :integer
  end
end
