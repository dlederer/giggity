class PhotosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :photo, through: :user
  
  def create
    if @photo.save
      render @photo
    else
      render :js => "alert('Error adding photo');"
    end
  end
  
  def update
    if @photo.update_attributes(params[:photo])
      render nothing: true
    else
      render :js => "alert('Error updating photo');"
    end
  end

  def destroy
    if @photo.destroy
      render nothing: true
    else
      render :js => "alert('Error removing photo');"
    end
  end

  
  def update_profile
    @user.profile_photo = @photo
    
    if @user.save
      render nothing:true
    else
      render :js => "alert('Error updating profile photo');"
    end
    
  end
end
