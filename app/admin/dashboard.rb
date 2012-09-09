ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc { I18n.t("active_admin.dashboard") }

  content :title => proc { I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span "Welcome to Active Admin. This is the default dashboard page."
        small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
      end
    end

    columns do
      column do
        panel "Recent Posts" do
          ul do
            Post.recent(5).collect do |post|
              li link_to(post.title, admin_post_path(post))
            end
          end
        end
      end
    end

  end
end
