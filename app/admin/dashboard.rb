ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    
    columns do
      column do
        panel "Recent New Users" do
          table_for User.last(10).reverse() do |t|
            t.column("Username") { |user| link_to(user.username, admin_user_path(user)) }
            t.column("Created At") { |user| user.created_at }
          end
        end
      end
      column do
        panel "Recent Updated Users" do
          table_for User.find(:all, order: 'updated_at DESC', limit: 10) do |t|
            t.column("Username") { |user| link_to(user.username, admin_user_path(user)) }
            t.column("Updated At") { |user| user.updated_at }
          end
        end
      end
    end
  end # content
end
