class Legacy::Message < Legacy::Base
  self.set_table_name "messages"
  
  belongs_to :user, class_name: 'Legacy::User'
  belongs_to :to, class_name: 'Legacy::User'
  belongs_to :conversation, class_name: 'Legacy::Conversation'
  
  def to_model
    to_id = Legacy::User.lookup(self.to.try(:id__))
    from_id = Legacy::User.lookup(self.user.try(:id__))
    if (to_id and from_id)
      ::Message.new do |message|
        message.content = self.content
        message.read = !self.unread
        message.from_id = from_id
        message.to_id = to_id
        message.created_at = self.created_at
        message.updated_at = self.updated_at
        #message.gig_id = Legacy::Conversation.lookup(self.conversation.try(:id__))
      end
    end
  end
  
end