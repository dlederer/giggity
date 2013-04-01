class SetGigDefaultToFalse < ActiveRecord::Migration
  def change
    change_column :gigs, :booker_confirm, :boolean, :default => false
    change_column :gigs, :performer_confirm, :boolean, :default => false
  end
end
