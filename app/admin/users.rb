ActiveAdmin.register User do

  scope :all, :default => true
  scope :admin

  index do
    column :id, :sortable => true
    column :email, :sortable => true
    column :created_at, :sortable => true
    column :last_sign_in_at, :sortable => true

    default_actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password, :input_html => { :autocomplete => 'off' }
      f.input :password_confirmation, :input_html => { :autocomplete => 'off' }
    end

    f.buttons
  end

end
