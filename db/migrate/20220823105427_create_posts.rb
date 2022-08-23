class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.string :title, null: false
      t.text :body, null:false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :business_hour
      t.string :price
      t.text :access, null: false

      t.timestamps
    end
  end
end
