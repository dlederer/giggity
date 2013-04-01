class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :to_id
      t.integer :from_id
      t.boolean :read
      t.string :content
      t.integer :conversation_id

      t.timestamps
    end
  end
end
