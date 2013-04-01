class Legacy::Review < Legacy::Base
  self.set_table_name "reviews"
  
  belongs_to :performer, class_name: 'Legacy::User'
  belongs_to :booker, class_name: 'Legacy::User'
  
  def to_model
    user_id = Legacy::User.lookup(self.performer.try(:id__))
    reviewer_id = Legacy::User.lookup(self.booker.try(:id__))
    if (user_id and reviewer_id)
      ::Review.new do |review|
        review.content = self.content
        review.score = self.score
        review.user_id = user_id
        review.reviewer_id = reviewer_id
        review.created_at = self.created_at
        review.updated_at = self.updated_at
      end
    end
  end
  
end