class ChangePhotosToId < ActiveRecord::Migration
  def change
    remove_attachment :users, :profile_picture
    add_column :users, :profile_photo_id, :integer
  end
end
