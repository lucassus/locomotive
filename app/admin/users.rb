ActiveAdmin.register User do

  scope :all, :default => true
  scope :admin

  filter :email
  filter :created_at
  filter :last_sign_in_at

  index do
    column :id
    column :email
    column :admin
    column :created_at
    column :last_sign_in_at

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
