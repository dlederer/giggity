class Review < ActiveRecord::Base
  belongs_to :gig
  belongs_to :reviewer, class_name: :User
  attr_accessible :content, :reviewer_id, :score, :user_id, :gig_id
end
