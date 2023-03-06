class ChangeColumnToAllowNull < ActiveRecord::Migration[6.1]
  
  def up
    change_column :members, :introduction,:text, null: true
  end

  def down
    change_column :members, :introduction,text, null: false
  end
end
