class ChangeBooleanDefaults < ActiveRecord::Migration
  def change
    change_column :users, :featured, :boolean, :default => false
    change_column :messages, :read, :boolean, :default => false
  end
end
