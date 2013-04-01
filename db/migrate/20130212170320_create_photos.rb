class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :description
      t.attachment :image

      t.timestamps
    end
  end
end
