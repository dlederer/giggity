class RemoveTimeFromGig < ActiveRecord::Migration
  def change
    remove_column :gigs, :time
  end
end
