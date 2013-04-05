class Song < ActiveRecord::Base
  include RankedModel
  ranks :row_order, with_same: :user_id
  belongs_to :user
  attr_accessible :embed_code, :audio, :row_order_position
  attr_accessible :audio_file_name, :audio_content_type, :audio_file_size, :audio_updated_at
  
  validates :embed_code, url: true, presence: true, unless: :audio_file_name?
  validates :audio_file_name, presence: true, unless: :embed_code?
  
  has_attached_file :audio
  validates_attachment_content_type :audio, :content_type => ['audio/mpg', 'audio/mpeg' ],
                                    :message => 'file must be of filetype .mp3'
end
