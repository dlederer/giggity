class AddTimeToGig < ActiveRecord::Migration
  def change
    add_column :gigs, :time, :time
  end
end
