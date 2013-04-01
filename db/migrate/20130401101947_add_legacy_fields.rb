class AddLegacyFields < ActiveRecord::Migration
  def change
    add_column :users, :legacy_id, :integer
    add_column :gigs, :legacy_id, :integer
    add_column :songs, :legacy_id, :integer
    add_column :messages, :legacy_id, :integer
    add_column :videos, :legacy_id, :integer
    add_column :posts, :legacy_id, :integer
    add_column :reviews, :legacy_id, :integer
    
    
    add_column :users, :legacy_class, :string
    add_column :gigs, :legacy_class, :string
    add_column :songs, :legacy_class, :string
    add_column :messages, :legacy_class, :string
    add_column :videos, :legacy_class, :string
    add_column :posts, :legacy_class, :string
    add_column :reviews, :legacy_class, :string
  end
end
