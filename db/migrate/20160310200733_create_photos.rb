class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :title, limit: 255
      t.text :description
      t.integer :user_id, null: false
      t.integer :album_id, null: false

      t.timestamps null: false
    end

    add_index :photos, :album_id
    add_index :photos, :user_id
  end
end
