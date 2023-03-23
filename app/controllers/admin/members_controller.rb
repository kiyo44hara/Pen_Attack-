class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.all.page(params[:page]).per(10)
  end

  # 会員のステータス更新。
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
