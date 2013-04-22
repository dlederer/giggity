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
      render :js => "alert('" + @video.errors.full_messages.to_sentence + "');"
    end
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    if @video.update_attributes(params[:video])
      render nothing: true
    else
      render :js => "alert('Error updating video');"
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    if @video.destroy
      render nothing: true
    else
      render :js => "alert('Error removing video');"
    end
  end
  
end
