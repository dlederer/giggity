module UsersHelper
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
  
  
end
