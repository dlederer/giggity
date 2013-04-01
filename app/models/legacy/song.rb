class Legacy::Song < Legacy::Base
  self.set_table_name "songs"
  
  belongs_to :user, class_name: 'Legacy::User'
  
  def to_model
    user_id = Legacy::User.lookup(self.user.try(:id__))
    if user_id
      ::Song.new do |song|
        song.user_id = user_id
        song.embed_code = self.embed_code
        song.updated_at = self.updated_at
        song.created_at = self.created_at
      end
    end
  end
  
end