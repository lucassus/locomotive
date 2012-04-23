ActiveAdmin.register User do

  index do
    column :id, :sortable => true
    column :email, :sortable => true
    column :created_at, :sortable => true
    column :last_sign_in_at, :sortable => true

    default_actions
  end

end
