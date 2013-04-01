class SongsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :song, through: :user

  def create
    if @song.audio_file_name
      @song.embed_code = nil
    end
    if @song.save
      render @song
    else
      render :js => "alert('Error adding song');"
    end
  end
  
  def update
    if @song.update_attributes(params[:song])
      render nothing: true
    else
      render :js => "alert('Error updating song');"
    end
  end

  def destroy
    if @song.destroy
      render nothing: true
    else
      render :js => "alert('Error removing song');"
    end
  end
  
end
