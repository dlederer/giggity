class Legacy::Conversation < Legacy::Base
  self.set_table_name "conversations"
  
  acts_as_importable :to => 'Gig'
  
  has_many :messages
  belongs_to :booker, class_name: 'Legacy::User'
  belongs_to :performer, class_name: 'Legacy::User'
  
  def to_model
    booker_id = Legacy::User.lookup(self.booker.try(:id__))
    performer_id = Legacy::User.lookup(self.performer.try(:id__))
    if (booker_id and performer_id)
      ::Gig.new do |gig|
        gig.approved = self.approved
        gig.price = self.price
        gig.booker_id = booker_id
        gig.performer_id = performer_id
        gig.rider = self.rider
        if !self.date.blank?
          gig.date = Date.strptime(date, "%m/%e/%y")
        end
        if !self.time.blank?
          gig.time = time
        end
        gig.time = self.time
        gig.location = self.location
        gig.booker_confirm = self.booker_confirm
        gig.performer_confirm = self.performer_confirm
        gig.created_at = self.created_at
        gig.updated_at = self.updated_at
        gig.status = "pending"
      end
    end
  end
  
end