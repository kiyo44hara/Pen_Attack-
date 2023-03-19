class MembersIntroductionDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :members, :introduction, nil
  end
end
