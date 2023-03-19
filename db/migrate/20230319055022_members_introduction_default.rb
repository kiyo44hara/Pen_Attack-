class MembersIntroductionDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :members, :introduction, from: "初めまして！よろしくおねがいします！", to: "Hello"
  end
end
