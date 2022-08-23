class CreateTagManagers < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_managers do |t|
      

      t.timestamps
    end
  end
end
