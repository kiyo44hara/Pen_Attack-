class Public::YellsController < ApplicationController
  before_action :authenticate_member!

  def show
    @post = Post.find(params[:post_id])
    yell_members = @post.yells.pluck(:member_id)
    @yell_members = Member.where(id: yell_members).page(params[:page])
  end

  def create
    # ログイン中のユーザーが、どの投稿に「応援」したのかわかるように記述。
    @post = Post.find(params[:post_id])
    @post_yell = Yell.new(member_id: current_member.id, post_id: params[:post_id])
    @post_yell.save
  end

  def destroy
    # createと同じくメンバーと投稿を特定するように記述。
    @post = Post.find(params[:post_id])
    @post_yell = Yell.find_by(member_id: current_member.id, post_id: [params[:post_id]])
    @post_yell.destroy
  end
end
