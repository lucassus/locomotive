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

end
