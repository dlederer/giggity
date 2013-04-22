module UsersHelper
  def menupic user
    user.profile_photo ? user.profile_photo.photo.url(:tiny) : asset_path('g_tiny.png')
  end
  def profpic user
    user.profile_photo ? user.profile_photo.photo.url(:medium) : asset_path('g_small.png')
  end
  def performer_pic user
    user.profile_photo ? user.profile_photo.photo.url(:thumb) : asset_path('g_small.png')
  end
  
  def has_pending_gig user1, user2
    has1 = Gig.where(booker_id:user1, performer_id:user2).empty?
    has2 = Gig.where(booker_id:user2, performer_id:user1).empty?
    return (has1 or has2)
  end
  
  def search_empty
    !params[:query] and !params[:category_id] and !params[:price] and !params[:address]
  end
  
  def user_rating user
    if user.reviews.count == 0
      "Unrated"
    else
      "#{@user.score}/10"
    end
  end
  
  def user_category user
    if user.category and user.subcategory != ""
      "#{user.category.name} / #{user.subcategory}"
    elsif user.category
      user.category.name
    elsif user.subcategory != ""
      user.subcategory
    end
  end
  
  
  def user_price_range user
    if user.price_min and user.price_max
      "$#{user.price_min} - $#{user.price_max}"
    elsif user.price_min
      "> $#{user.price_min}"
    elsif user.price_max
      "< $#{user.price_max}"
    else
      "Not Listed"
    end
  end
  
end
