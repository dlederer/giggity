class ConnectMessageToGig < ActiveRecord::Migration
  def change
    rename_column :messages, :conversation_id, :gig_id
  end
end
