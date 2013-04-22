class UsersController < ApplicationController
  load_and_authorize_resource :user
  
  def index
    @pending_gigs = Gig.where(booker_id: current_user.id, status: "pending").order('date ASC').all
    @performers = User.performers
    @featured = @performers.select { |performer|
      performer.featured?
    }
    
  end

  def show
    @user ||= current_user
    @posts = @user.posts.order('created_at DESC').all
    @post = @user.posts.new
    @reviews = @user.reviews
    @photos = @user.photos
    @photos = @photos.where('id != ?', @user.profile_photo.id) unless !@user.profile_photo 
    if @user.has_role? :performer
      render 'performer_show'
    elsif @user.has_role? :booker
      render 'booker_show'
    end
  end
  
  def edit
    
  end
  
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        if params[:user][:email]
          notice = "You must confirm your new email address"
        else
          notice = 'Profile was successfully updated.'
        end
        format.html  { redirect_to user_path(@user),
                      :notice => notice }
        format.json  { head :no_content }
      else
        format.html  { redirect_to edit_user_path(@user, anchor: params[:user][:tab]),
                      :notice => 'Failed to update profile.'}
        format.json  { render :json => @post.errors,
                      :status => :unprocessable_entity }
      end
    end
  end
  
  def search
    @users = User.performers
    if params[:query] and params[:query] != ""
      @users = @users.by_query(params[:query])
    end
  
    price_min = (params[:price_min] and  params[:price_min] != "") ? params[:price_min] : 0
    price_max = (params[:price_max] and  params[:price_max] != "") ? params[:price_max] : (2**(0.size * 8 -2) -1)
    @users = @users.by_price(price_min, price_max)
    
    if params[:category_id] and params[:category_id] != ""
      @users = @users.by_category(params[:category_id])
    end
    if params[:address] and params[:address] != ""
      @users = @users.near(params[:address], 50)
    end
  end
  
  def guest
    
  end

end
