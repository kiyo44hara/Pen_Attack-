class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.integer :member_id, null: false
      t.integer :post_id, null: false
      t.text :comment, null: false
      t.boolean :is_deleted, null: false, default: "false"

      t.timestamps
    end
  end
end
