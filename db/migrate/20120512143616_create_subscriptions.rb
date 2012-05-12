class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, :null => false
      t.string :recurly_uuid, :null => false

      t.timestamps
    end
  end
end
