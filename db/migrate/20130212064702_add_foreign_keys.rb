class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :users, :category_id, :integer
    add_column :users, :college_id, :integer
  end
end
