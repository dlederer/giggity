class Legacy::User < Legacy::Base
  self.set_table_name "users"
  
  attr_accessible :profile_pic
  
  has_many :songs
  has_many :videos
  has_many :posts
  has_many :messages
  has_many :reviews
  
  has_attached_file   :profile_pic,
    styles:
      { profile: "300x300#", thumb: "100x100#" }, 
      storage: :s3,
      :path => "giggity/users/profile_pics/:attachment/:style/:id.:extension",
      s3_credentials: {
        bucket: 'giggity',
        access_key_id: 'AKIAJ7MVHNF7RGCWOMEA',
        secret_access_key: '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'
    }
  
  def to_model
    ::User.new do |user|
      user.created_at = self.created_at
      user.display_name = self.name
      user.username = self.email
      user.password = self.password
      user.email = self.email
      user.blurb = self.blurb
      user.created_at = self.created_at
      user.updated_at = self.updated_at
      user.featured = self.featured || false
      user.subcategory = self.subcategory
      if self.user_role == "Performer"
        user.add_role :performer
      elsif self.user_role == "Booker"
        user.add_role :booker
      else
        user.add_role :performer
      end
      if self.admin
        user.add_role :admin
      end
      cat = Category.find_by_name(self.category)
      if cat
        user.category_id = cat.id
      end
      if !self.price_level.blank?
        user.price_min = self.price_level.split(' - ')[0].gsub(/[^0-9]/, "").to_i
        user.price_max = self.price_level.split(' - ')[1].gsub(/[^0-9]/, "").to_i
      end
    end
  end
end