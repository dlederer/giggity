class ChangeConversationToGig < ActiveRecord::Migration
  def change
    remove_column :conversations, :gig_id
    rename_table :conversations, :gigs
  end
end
