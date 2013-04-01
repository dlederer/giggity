class Review < ActiveRecord::Base
  belongs_to :gig
  attr_accessible :content, :reviewer_id, :score, :user_id, :gig_id
end
