class Video < ActiveRecord::Base
  include RankedModel
  ranks :row_order, with_same: :user_id
  belongs_to :user
  attr_accessible :embed_code, :row_order_position
  validates :embed_code, presence: true
end
