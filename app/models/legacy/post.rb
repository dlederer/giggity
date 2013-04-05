class Legacy::Post < Legacy::Base
  self.set_table_name "posts"
  
  belongs_to :user, class_name: 'Legacy::User'
  
  def to_model
    user_id = Legacy::User.lookup(self.user.try(:id__))
    if user_id
      ::Post.new do |post|
        post.content = self.content
        post.user_id = user_id
        post.created_at = self.created_at
        post.updated_at = self.updated_at
      end
    end
  end
  
end