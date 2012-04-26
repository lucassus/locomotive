class CreateEncounters < ActiveRecord::Migration
  def change
    create_table :encounters do |t|
      t.integer :user_id, :null => false
      t.integer :other_user_id, :null => false
      t.string :interest_type, :null => false, :limit => 32

      t.timestamps
    end

    add_index :encounters, :user_id
    add_index :encounters, :other_user_id
    add_index :encounters, :interest_type
    add_index :encounters, [:user_id, :other_user_id], :unique => true
  end
end
