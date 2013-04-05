class GigsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :gig
  # GET /gigs
  # GET /gigs.json
  def index
    @user = current_user
    if @user.has_role? :performer
      @gigs = Gig.where(performer_id: @user.id)
      @opposite_type = 'Booker'
    elsif @user.has_role? :booker
      @gigs = Gig.where(booker_id: @user.id)
      @opposite_type = 'Performer'
    end
    @gigs = @gigs.order('date ASC').all
    @pending_gigs = @gigs.select { |gig|
      gig.status == 'pending'
    }
    @completed_gigs = @gigs.select { |gig|
      gig.status == 'completed'
    }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gigs }
    end
  end

  # GET /gigs/1
  # GET /gigs/1.json
  def show
    @messages = @gig.messages.order('created_at DESC').all
    @messages.each do |message|
      if message.to_id == current_user.id
        message.read = true
        message.save
      end
    end
    @performer = @gig.performer
    @message = @gig.messages.new
    
    @review = @gig.review
    if !@review
      @review = @gig.build_review
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gig }
    end
  end

  def create
    @gig.booker_id ||= current_user.id
    @gig.messages[0].from_id ||= current_user.id
    respond_to do |format|
      if @gig.save
        format.html { redirect_to @gig, notice: 'Photo was successfully created.' }
        format.json { render json: @gig, status: :created, location: @gig }
      else
        format.html { render action: "new" }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gigs/1
  # PUT /gigs/1.json
  def update
    respond_to do |format|
      if @gig.update_attributes(params[:gig])
        format.html { redirect_to @gig, notice: 'Gig was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gigs/1
  # DELETE /gigs/1.json
  def destroy
    @gig.destroy

    respond_to do |format|
      format.html { redirect_to gigs_url }
      format.json { head :no_content }
    end
  end
end
