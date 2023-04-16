class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.all.page(params[:page]).per(10)
      case params[:sort]
      when "member_latest"
        @members = @members.member_latest
      when "member_old"
        @members = @members.member_old
      when "active"
        @members = @members.active
      when "not_active"
        @members = @members.not_active
      end
        @members = @members.page(params[:page]).per(10)
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
