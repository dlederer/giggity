class ChangeGigDefaults < ActiveRecord::Migration
  def change 
    change_column :gigs, :approved, :boolean, default: false
  end
end
