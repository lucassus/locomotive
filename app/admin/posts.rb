ActiveAdmin.register Post do

  scope :all, :default => true
  scope :published
  scope :unpublished

  index do
    column :title
    column :published
    column :created_at

    default_actions
  end

  form do |f|
    f.inputs "Post" do
      f.input :title
      f.input :body, :input_html => { :class => 'editor' }
      f.input :published
    end

    f.buttons
  end

  show do
    h3 post.title

    div do
      markdown(post.body).html_safe
    end

    span { "Published: #{post.published?} |" }
    span { "Created at: #{post.created_at} |" }
    span { "Updated at: #{post.updated_at}" }
  end

end
