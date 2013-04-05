class Legacy::Video < Legacy::Base
  self.set_table_name "videos"
  
  belongs_to :user, class_name: 'Legacy::User'
  
  def to_model
    user_id = Legacy::User.lookup(self.user.try(:id__))
    if user_id
      ::Video.new do |video|
        video.user_id = user_id
        code = self.embed_code
        if (code =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]) == nil
            code = Nokogiri::HTML(code).css('iframe').first['src']
        end
        video.embed_code = code
        video.updated_at = self.updated_at
        video.created_at = self.created_at
      end
    end
  end
  
end