class AddSubcategory < ActiveRecord::Migration
  def change
    add_column :users, :subcategory, :string
  end
end
