class Admin::MembersController < ApplicationController
    before_action :authenticate_admin!

  def index
    @members = Member.all
  end

  # 会員のステータス更新。
  # また、ApplicationControllerにて、管理者権限と、会員本人以外はステータスの更新ができないようにしています。
  def update
    @member = Member.find(params[:id])
    if @member.is_deleted == false
      @member.update(is_deleted: true)
      redirect_to admin_path, notice: '会員を退会させました'
    elsif @member.is_deleted == true
      @member.update(is_deleted: false)
      redirect_to admin_path, notice: '会員を復活させました'
    else
      reder 'index'
    end
  end
end
