ActiveAdmin.register StaticPage do
  actions :index, :show, :edit, :update

  index do
    column :name
    column :updated_at

    default_actions
  end

  show do
    h3 static_page.name

    div do
      markdown(static_page.content).html_safe
    end

    span { "Created at: #{static_page.created_at} |" }
    span { "Updated at: #{static_page.updated_at}" }

    active_admin_comments
  end

  form do |f|
    f.inputs %Q{Static page "#{f.object.name}"} do
      f.input :content, :input_html => { :class => 'editor' }
    end

    f.actions
  end

end
