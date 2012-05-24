ActiveAdmin.register User do

  scope :all, :default => true
  scope :admin
  scope :suspended

  filter :email
  filter :created_at
  filter :last_sign_in_at

  index do
    column :id
    column :email
    column :admin
    column :suspended
    column :created_at
    column :last_sign_in_at

    default_actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :password, :input_html => { :autocomplete => 'off' }
      f.input :password_confirmation, :input_html => { :autocomplete => 'off' }

      f.input :suspended
    end

    f.inputs do
      f.input :avatar
    end

    f.buttons
  end

  controller do

    def update
      @user = User.find(params[:id])

      result = if params[:user][:password].present? || params[:user][:password_confirmation].present?
                @user.update_attributes!(params[:user])
              else
                @user.update_without_password(params[:user])
              end

      if result
        flash[:notice] = 'User was successfully updated.'
        redirect_to admin_user_path(@user)
      else
        render 'edit'
      end
    end

  end

end
