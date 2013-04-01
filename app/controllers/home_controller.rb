class HomeController < ApplicationController
  def index
    
    if user_signed_in?
      if current_user.has_role? :performer
        redirect_to :controller => 'users', :action => 'show', id: current_user.id
      elsif current_user.has_role? :booker
        redirect_to :controller => 'users', :action => 'index'
      end
    end
    
    @users = User.all
    @categories = Category.all
    @colleges = College.all
    
    @q = User.search(params[:q])
    @people = @q.result(:distinct => true)
  end
  
  def guest
    current_or_guest_user
  end
end
