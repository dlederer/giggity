class User < ActiveRecord::Base
  rolify
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable
         
  belongs_to :category
  belongs_to :college
  
  belongs_to :profile_photo, class_name: :Photo
  has_many :photos, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :booker_gigs, class_name: :Gig, foreign_key:'booker_id', :dependent => :destroy
  has_many :performer_gigs, class_name: :Gig, foreign_key:'performer_id', :dependent => :destroy
  has_many :reviews, through: :performer_gigs
  
  accepts_nested_attributes_for :videos, allow_destroy: true
  accepts_nested_attributes_for :songs, allow_destroy: true
  accepts_nested_attributes_for :posts, allow_destroy: true
  accepts_nested_attributes_for :profile_photo, allow_destroy: true
  
  attr_accessor :newrole, :tab, :confirmed_tou
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :display_name, :email, :password, :password_confirmation, :remember_me, :newrole
  attr_accessible :address, :address_latitude, :address_longitude
  attr_accessible :category_id, :subcategory, :blurb, :tab, :featured, :price_min, :price_max, :confirmed_tou
  attr_accessible :profile_photo_attributes, :songs_attributes, :videos_attributes, :posts_attributes
  
  attr_accessible :created_at
  
  validates_presence_of   :email
  validates_presence_of   :username
  validates_uniqueness_of :username
  validates_format_of     :email, :with  => /\A[^@]+@[^@]+\z/, :allow_blank => true
  validates_associated :songs, :videos, :photos
 # validates_acceptance_of :confirmed_tou
 # validates :newrole, inclusion:[:booker, :performer], on: :create

  with_options :if => :password_required? do |v|
    v.validates_presence_of     :password
    v.validates_confirmation_of :password
    v.validates_length_of       :password, :within => 8..128, :allow_blank => true
  end
  
  geocoded_by :address, :latitude  => :address_latitude, :longitude => :address_longitude
  reverse_geocoded_by :address_latitude, :address_longitude
  
  scope :by_query, lambda { |query| where("display_name ILIKE ? OR email ILIKE ? OR blurb ILIKE ? OR subcategory ILIKE ?", '%'+query+'%', '%'+query+'%', '%'+query+'%', '%'+query+'%') }
  scope :by_price, lambda { |price_min, price_max| where("(price_min IS NULL OR price_min >= ?) AND (price_max IS NULL OR price_max <= ?)", price_min, price_max) }
  scope :by_category, lambda { |category_id| where(:category_id => category_id) }
  
  def newrole=(a_role) #set the name
    if a_role == "performer"
      self.add_role :performer
      logger.debug "Added a performer"
    elsif a_role == "booker"
      self.add_role :booker
      logger.debug "Added a booker"
    end    
  end
  
  def name
    if self.display_name != ""
      self.display_name
    else
      self.username
    end
  end
  
  def self.performers
    User.with_role :performer
  end
  
  def gigs
    return self.booker_gigs + self.performer_gigs
  end
  
  def unread_messages
    Message.find(:all, :conditions => [ "to_id = ? AND read = 'f'", id]).count
  end
  
  def score
    score = Review.average(:score, conditions:['user_id = ?',self.id])
    if score == nil
      score = 'N/A'
    end
    score
  end
  
  # Checks whether a password is needed or not. For validations only.
  # Passwords are always required if it's a new record, or if the password
  # or confirmation are being set somewhere.
  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
  
  def self.price_level_choices
    [["Select a price level", nil], "$0 - $200", "$200 - $500", "$500 - $1,000", "$1,000 - $2,000", "$2,000 - $5,000", "$5,000 - $10,000", "$10,000 - $20,000", "> $20,000"]
  end
  
  def page_title
    self.username
  end
  
  def account_type
    if self.has_role? :performer
      "Performer"
    elsif self.has_role? :booker
      "Booker"
    else
      "Other"
    end
  end
  
end
