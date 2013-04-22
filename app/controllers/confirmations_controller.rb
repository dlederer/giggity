class ConfirmationsController < Devise::ConfirmationsController

  protected

  def after_confirmation_path_for(resource_name, resource)
    edit_user_path(current_user, anchor: :profile)
  end
end