class ChangeBlurbToText < ActiveRecord::Migration
  def change
    change_column :users, :blurb, :text
  end
end
