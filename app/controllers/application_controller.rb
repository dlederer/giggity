class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def authenticate_admin!
    authenticate_user! 
    unless current_user.has_role? :admin
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path 
    end
  end
      
end
