class StaticPagesController < ApplicationController
  
  def index
  end
  
  def about
  end
  
  def demo_profile
    render layout: false
#     reviewer1 = User.new
#     reviewer1.display_name = 'Mike Booker'
#     
#     
#     @user = User.new
#     @user.add_role :performer
#     @user.id = -1
#     @user.display_name = 'Shav and Mentos'
#     @user.category_id = 1
#     @user.subcategory = 'Hip-Hop/Pop'
#     @user.price_min = 500
#     @user.price_max = 1000
#     song1 = Song.new(embed_code: 'http://api.soundcloud.com/tracks/54950887')
#     song2 = Song.new(embed_code: 'http://api.soundcloud.com/tracks/54908475')
#     song3 = Song.new(embed_code: 'http://api.soundcloud.com/tracks/54905835')
#     @songs = [song1, song2, song3]
#     video1 = Video.new(embed_code: 'http://www.youtube.com/watch?v=WX0OnoAmJUU')
#     video2 = Video.new(embed_code: 'http://www.youtube.com/watch?v=QNQ6fc3xzLQ')
#     video3 = Video.new(embed_code: 'http://www.youtube.com/watch?v=unGjzvNkJPQ')
#     @videos = [video1, video2, video3]
#     @photos = []
#     review1 = Review.new
#     review1.content = 'These guys were really great. They rocked the crowd, were on time and professional, and made my venue a bunch of profit. I would highly suggest them to anyone else.'
#     review1.score = 9
#     @reviews = [review1]
#     @posts = []
#     render 'users/performer_show'
  end
  
  def demo_convo
    render layout: false
  end
end