class AddColumnsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :address, :string
  end
end