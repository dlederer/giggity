class Gig < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_one :review
  
  belongs_to :booker, class_name: :User
  belongs_to :performer, class_name: :User
  
  attr_accessible :approved, :booker_confirm, :booker_id, :date, :time, :location, :performer_confirm, :performer_id, :price, :rider, :status, :messages_attributes
  accepts_nested_attributes_for :messages

  before_save :default_values

  def date=(date)
    date = Date.strptime(date, '%m/%d/%Y') if date.is_a?(String)
    write_attribute(:date, date)
  end

  def opposite(user)
    if user.has_role? :performer
      self.booker
    elsif user.has_role? :booker
      self.performer
    end
  end
  
  def default_values
    self.status ||= 'pending'
  end

end
