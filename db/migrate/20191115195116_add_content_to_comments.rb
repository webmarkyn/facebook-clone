class AddContentToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :content, :text
  end
end
