class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit]
  before_action :is_matching_login_member, only: [:edit, :update, :destroy]
  before_action :is_deleted_true_member, only: [:show]

  def yells
    @member = Member.find(params[:id])
    yells = Yell.where(member_id: @member.id).pluck(:post_id)
    @posts = Post.where(id: yells).latest.page(params[:page])
  end

  def show
    @posts = @member.posts
    if params[:sort]
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
    else
      @posts = @member.posts.latest.page(params[:page]).per(8)
    end
  end

  def edit
    @member = Member.find(params[:id])
    @posts = @member.posts.latest.limit(8)
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
       redirect_to member_path, notice: "プロフィールを更新しました。"
    else
      @posts = @member.posts.limit(8)
      render:edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:profile_image, :name, :introduction)
  end

  def ensure_guest_member
    @member = Member.find(params[:id])
    if @member.name == 'guestmember'
      redirect_to member_path(current_member), notice: 'ゲストメンバーのプロフィール変更はできません！'
    end
  end

  # 本人の登録情報を、他人に編集されないようにしています。
  def is_matching_login_member
    @member = Member.find(params[:id])
    unless @member.id == current_member.id
      redirect_to root_path, notice: '他人の情報は編集できません！'
    end
  end

# 退会済みの会員がアクセス出来ないようにしています。
  def is_deleted_true_member
   @member = Member.find(params[:id])
    if @member.is_deleted == true
      redirect_to root_path, notice: '既に退会済みの会員です！'
    end
  end
end
