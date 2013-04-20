class Song < ActiveRecord::Base
  include RankedModel
  ranks :row_order, with_same: :user_id
  belongs_to :user
  attr_accessible :embed_code, :audio, :row_order_position
  attr_accessible :audio_file_name, :audio_content_type, :audio_file_size, :audio_updated_at
  
  validates :embed_code, url: true, presence: true, unless: :audio_file_name?
  validates :audio_file_name, presence: true, unless: :embed_code?
  
  has_attached_file :audio,
                    storage: :s3,
                    bucket: 'giggity_storage',
                    s3_credentials: {
                      access_key_id: 'AKIAJBMLPUJYAPWYUNYA',
                      secret_access_key: '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'
                    }
  validates_attachment_content_type :audio, :content_type => ['application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3'],
                                    :message => 'file must be of filetype .mp3'
  validates_attachment_size :audio, :less_than => 10.megabytes
  
  before_post_process :image?
  
  def image?
    !(audio_content_type =~ /^image.*/).nil?
  end
  
end
