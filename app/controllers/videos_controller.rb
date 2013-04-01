class VideosController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :video, through: :user

  # POST /videos
  # POST /videos.json
  def create
    if @video.save
      render @video
    else
      logger.debug @video.errors.full_messages.join("\n")
      render :js => "alert('Error adding song');"
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    if @video.update_attributes(params[:video])
      render nothing: true
    else
      render :js => "alert('Error updating song');"
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    if !@video.destroy
      render :js => "alert('Error removing song');"
    end
  end
  
end
