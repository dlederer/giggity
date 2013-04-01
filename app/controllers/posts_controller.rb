class PostsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :user
  load_and_authorize_resource :post, through: :user

  # GET /posts/1/edit
  def edit
    
  end

  # POST /posts
  # POST /posts.json
  def create
    if @post.save
      render @post
    else
      render :js => "alert('Error saving update');"
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render json: @post }
      else
        format.html { redirect_to @user, notice: 'Failed to update post.' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end
end
