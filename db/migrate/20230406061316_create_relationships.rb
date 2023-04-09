class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      t.integer :member_id
      t.integer :follower_id
      t.timestamps
    end

    # add_foreign_key :relationships, :members, column: :member_id
    # add_foreign_key :relationships, :members, column: :follower_id
    # 本番環境に適応できない為コメントアウト

    add_index :relationships, [:member_id, :follower_id], unique: true
  end
end
