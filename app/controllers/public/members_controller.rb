class Public::MembersController < ApplicationController
  before_action :ensure_guest_member, only: [:edit]

  def yells
    @member = Member.find(params[:id])
    yells = Yell.where(member_id: @member.id).pluck(:post_id)
    @posts = Kaminari.paginate_array(Post.find(yells)).page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts
    case params[:sort]
    when "latest"
      @posts = @posts.latest
    when "old"
      @posts = @posts.old
    when "star_latest"
      @posts = @posts.star_latest
    when "star_old"
      @posts = @posts.star_old
    end
    @posts = @posts.page(params[:page]).per(8)
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
