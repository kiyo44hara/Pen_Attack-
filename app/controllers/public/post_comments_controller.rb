class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!

  def create
    post = Post.find(params[:post_id])
    comment = current_member.post_comments.new(post_comment_params)
    comment.post_id = post.id
    if comment.save
      redirect_to post_path(post), notice: "コメントの投稿に成功しました。"
    else
      @post = Post.find(params[:post_id])
      redirect_to post_path(post), notice: "エラー：コメントを空にすることは出来ません。"
    end
  end

  def destroy
    if PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
      redirect_to post_path(params[:post_id]), notice: "コメントを削除しました。"
    else
      redirect_to post_path(params[:post_id]), notice: "コメントを削除出来ませんでした。"
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
