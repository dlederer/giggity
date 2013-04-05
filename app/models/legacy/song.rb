class Legacy::Song < Legacy::Base
  self.set_table_name "songs"
  
  belongs_to :user, class_name: 'Legacy::User'
  
  def to_model
    user_id = Legacy::User.lookup(self.user.try(:id__))
    isBBCode = Regexp.new(Regexp.escape('[soundcloud url='))
    if user_id
      ::Song.new do |song|
        song.user_id = user_id
        code = self.embed_code
        if code =~ isBBCode
          almost = code.split('url')[1].split('params')[0]
          code = almost[2, almost.length - 4]
        elsif (code =~ URI::DEFAULT_PARSER.regexp[:ABS_URI]) == nil
          code = Nokogiri::HTML(code).css('iframe').first['src']
          code = CGI::parse(code).values.first.first
        end
        song.embed_code = code
        song.updated_at = self.updated_at
        song.created_at = self.created_at
      end
    end
  end
  
end