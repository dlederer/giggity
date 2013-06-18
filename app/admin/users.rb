ActiveAdmin.register User do

  filter :username
  filter :email
  filter :created_at

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :created_at
    column "Type" do |user|
      if user.has_role? :performer
        "Performer"
      elsif user.has_role? :booker
        "Booker"
      end
    end
    actions do |user|
      link_to "Edit on site", edit_user_path(user), :class => "member_link"
    end
    
  end
  
  show title: :page_title do |ad|
    panel "Account Info" do
      attributes_table_for user do
        row :username
        row :email
        row :address
        row :account_type
        row :featured
        row :created_at
        row :updated_at
      end
    end
    panel "Profile Info" do
      attributes_table_for user do
        row :display_name
        row :blurb
        if ad.has_role? :performer
          row :category
          row :subcategory
          row :price_min
          row :price_max
        end
      end
    end
    panel "Login Info" do
      attributes_table_for user do
        row :sign_in_count
        row :current_sign_in_at
        row :last_sign_in_at
        row :current_sign_in_ip
        row :last_sign_in_ip
      end
    end
    panel "Updates" do
      table_for user.posts do
        column "Content" do |post| 
          post.content
        end
        column "Updated at" do |post| 
          post.updated_at
        end
      end
    end
  end
  
  form do |f|
    f.inputs "Account Settings" do
      f.input :username
      f.input :email
      f.input :address
      f.input :account_type
    end
    f.inputs "Admin Settings" do
      f.input :featured
    end
    f.inputs "Profile Settings" do
      f.input :display_name
      f.input :blurb
      if f.object.has_role? :performer
        f.input :category
        f.input :subcategory
        f.input :price_min
        f.input :price_max
      end
    end
    f.has_many :posts do |post_f|
      post_f.inputs "Posts" do
        if !post_f.object.nil?
          post_f.input :content
          post_f.input :_destroy, as: :boolean, label: "Destroy?"
        end
      end
    end
    f.actions
  end
  
  action_item :only => :show do
    link_to('Edit on site', edit_user_path(user))
  end
  
  batch_action :feature do |selection|
    User.find(selection).each do |user|
      user.featured = true
      user.save
      redirect_to collection_path
    end
  end
end