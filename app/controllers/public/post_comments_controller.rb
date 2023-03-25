class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_member.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash.now[:notice] = "コメントの投稿に成功しました。"
    else
      flash.now[:notice] = "エラー：コメントを空にすることは出来ません。"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    if PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
      flash.now[:notice] = "コメントを削除しました。"
    else
      flash.now[:notice] = "エラー：コメントを削除出来ませんでした。"
    end
    @post_comment = PostComment.new
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
