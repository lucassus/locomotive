class AddAgeGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer, :null => true
    add_column :users, :gender, :string, :null => true, :limit => 8

    add_index :users, :age
    add_index :users, :gender
  end
end
