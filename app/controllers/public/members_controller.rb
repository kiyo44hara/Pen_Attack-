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
    if params[:star_latest]
      @posts = Post.star_latest.limit(8)
    elsif params[:star_old]
      @posts = Post.star_old.limit(8)
    elsif params[:old]
      @posts = Post.old.limit(8)
    else params[:latest]
      @posts = Post.latest.limit(8)
    end

  end

  def edit
    @member = Member.find(params[:id])
    @posts = @member.posts.latest.limit(8)
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
