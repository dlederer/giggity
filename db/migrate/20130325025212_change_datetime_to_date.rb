class ChangeDatetimeToDateAndTime < ActiveRecord::Migration
  def change
    change_column :gigs, :date, :date
    add_column :gigs, :time, :time
  end
end
