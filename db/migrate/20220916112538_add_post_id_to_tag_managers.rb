class AddPostIdToTagManagers < ActiveRecord::Migration[6.1]
  def change
    add_column :tag_managers, :post_id, :integer
    add_column :tag_managers, :tag_id, :integer
    add_index :tag_managers, [:post_id, :tag_id], unique: true
  end
end
