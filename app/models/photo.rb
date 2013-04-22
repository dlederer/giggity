class Photo < ActiveRecord::Base
  include RankedModel
  ranks :row_order, with_same: :user_id
  attr_accessible :description, :photo, :row_order_position
  attr_accessible :photo_file_name, :photo_file_content_type, :photo_file_file_size
  
  belongs_to :user
  
  has_attached_file :photo,
    :styles => {:medium => "300x300>", :thumb => "100x100>", :tiny =>"50x50"},
    :default_url => '/images/g.png', 
    storage: :s3,
    s3_credentials: {
      bucket: 'giggity_storage',
      access_key_id: 'AKIAJBMLPUJYAPWYUNYA',
      secret_access_key: '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'
    }
    
  validates_attachment_presence :photo
end
