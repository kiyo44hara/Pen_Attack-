class Public::MembersController < ApplicationController
  before_action :ensure_guest_member, only: [:edit]

  def yells
    @member = Member.find(params[:id])
    yells = Yell.where(member_id: @member.id).pluck(:post_id)
    @yell_posts = Post.find(yells)
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts
    if params[:my_star_latest]
      @posts = Post.my_star_latest(current_member.id).page(params[:page]).per(8)
    elsif params[:my_star_old]
      @posts = Post.my_star_old(current_member.id).page(params[:page]).per(8)
    elsif params[:my_old]
      @posts = Post.my_old(current_member.id).page(params[:page])
    else params[:my_latest]
      @posts = Post.my_latest(current_member.id).page(params[:page]).per(8)
    end
  end

  def edit
    @member = Member.find(params[:id])
    @posts = @member.posts.page(params[:page]).per(8)
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
