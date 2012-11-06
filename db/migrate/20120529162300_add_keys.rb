class AddKeys < ActiveRecord::Migration
  def change
    add_foreign_key "user_accounts", "users", dependent: :delete
  end
end
