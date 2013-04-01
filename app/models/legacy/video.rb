class Legacy::Video < Legacy::Base
  self.set_table_name "videos"
  
  belongs_to :user, class_name: 'Legacy::User'
  
  def to_model
    user_id = Legacy::User.lookup(self.user.try(:id__))
    if user_id
      ::Video.new do |video|
        video.user_id = user_id
        video.embed_code = self.embed_code
        video.updated_at = self.updated_at
        video.created_at = self.created_at
      end
    end
  end
  
end