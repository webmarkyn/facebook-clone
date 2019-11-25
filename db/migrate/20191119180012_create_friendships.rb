class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships, primary_key:[:requesting_user_id , :requested_user_id] do |t|
      t.integer :requesting_user_id
      t.integer :requested_user_id
      t.boolean :mutual

      t.timestamps
    end
  end
end
