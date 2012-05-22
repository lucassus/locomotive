class AddSuspendedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :suspended, :boolean
    change_column :users, :suspended, :boolean, :default => false
    add_index :users, :suspended
  end
end
