class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :member_id
      t.string :title, null: false
      t.text :body, null: false
      t.text :appeal_point, null: false
      t.text :improve_point, null: false
      t.integer :production_time, null: false
      t.integer :unit, null: false, default: 0
      t.string :star, null: false

      t.timestamps
    end
  end
end
