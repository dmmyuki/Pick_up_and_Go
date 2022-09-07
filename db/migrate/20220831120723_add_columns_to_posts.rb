class AddColumnsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :address, :string
    add_column :posts, :user_id, :integer
  end
end
