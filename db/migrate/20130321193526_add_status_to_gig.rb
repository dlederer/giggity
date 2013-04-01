class AddStatusToGig < ActiveRecord::Migration
  def change
    add_column :gigs, :status, :string
  end
end
