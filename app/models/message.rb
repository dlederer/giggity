class Message < ActiveRecord::Base
  belongs_to :gig
  belongs_to :from, class_name: "User"
  belongs_to :to, class_name: "User"
  attr_accessible :content, :gig_id, :from_id, :read, :to_id
end
