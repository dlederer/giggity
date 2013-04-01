class ReviewsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :gig
  load_and_authorize_resource :review, through: :gig, :singleton => true

  # POST /reviews
  # POST /reviews.json
  def create
    respond_to do |format|
      if @review.save
        format.html { redirect_to @gig, notice: 'Review was successfully created.' }
        format.json { render json: @review, status: :created, location: @review }
      else
        format.html { redirect_to @gig, notice: 'Failed to create review.' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @gig, notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @gig, notice: 'Failed to update review.' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy

    respond_to do |format|
      format.html { redirect_to @gig }
      format.json { head :no_content }
    end
  end
end
