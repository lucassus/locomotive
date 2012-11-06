class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.integer :user_id, null: false
      t.string :provider, null: false, limit: 16
      t.string :uid, null: false
      t.string :token
      t.text :auth_response

      t.timestamps
    end

    add_index :user_accounts, :user_id
    add_index :user_accounts, [:user_id, :provider], unique: true
  end
end
