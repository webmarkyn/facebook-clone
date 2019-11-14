class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :context
      t.integer :user_id

      t.timestamps
    end
  end
end
