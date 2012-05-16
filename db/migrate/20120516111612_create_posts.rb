class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, :null => false
      t.text :body
      t.boolean :published, :null => false, :default => false

      t.timestamps
    end
  end
end
