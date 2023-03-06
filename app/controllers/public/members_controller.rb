class Public::MembersController < ApplicationController
  before_action :ensure_guest_member, only: [:edit]


  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    @member.update(member_params)
    redirect_to member_path
  end

  def destroy
  end

  private

  def member_params
    params.require(:member).permit(:profile_image, :name, :introduction)
  end

  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.name == 'guestmember'
      redirect_to member_path(current_member), notice: 'ゲストメンバーはプロフィール変種画面へ遷移できません！'
    end
  end
end
