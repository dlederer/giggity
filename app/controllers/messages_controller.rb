class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :gig
  load_and_authorize_resource :message, through: :gig

  def create
    if @message.save
      UserMailer.message_notification(@message.from, @message.to, @message.content).deliver
      render @message
    else
      render :js => "alert('Error sending message');"
    end
  end

  def destroy
    if !@message.destroy
      render :js => "alert('Error removing message');"
    end
  end

end
