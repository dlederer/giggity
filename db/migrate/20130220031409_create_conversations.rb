class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :booker_id
      t.integer :performer_id
      t.integer :gig_id
      t.integer :price
      t.boolean :approved
      t.text :rider
      t.datetime :date
      t.string :location
      t.boolean :booker_confirm
      t.boolean :performer_confirm

      t.timestamps
    end
  end
end
