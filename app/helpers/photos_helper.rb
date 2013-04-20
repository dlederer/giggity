module PhotosHelper
  def profile_link photo
    if photo.user.profile_photo == photo
      'Selected Profile'
    else
      link_to 'Profile Picture', update_profile_user_photo_path(photo.user, photo), method: :put, remote:true, class: "btn btn-tiny"
    end
  end
end
