class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.text :appeal_point, null: false
      t.text :improve_point, null: false
      t.integer :production_time, null: false
      t.string :star

      t.timestamps
    end
  end
end
