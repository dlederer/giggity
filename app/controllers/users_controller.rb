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
    @posts = @user.posts.order('created_at DESC').all
    @post = @user.posts.new
    @reviews = @user.reviews
  end
  
  def edit
    @user.videos.build
    @user.photos.build
    @user.build_profile_photo
  end
  
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html  { redirect_to edit_user_path(@user, anchor: params[:user][:tab]),
                      :notice => 'Profile was successfully updated.' }
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
    if params[:price] and params[:price] != ""
      @users = @users.by_price(params[:price])
    end
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
