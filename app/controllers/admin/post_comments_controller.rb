class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  # コメントのステータス更新。
  def update
    @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    if @post_comment.is_deleted == false
      @post_comment.update(is_deleted: true)
      redirect_to admin_post_path(params[:post_id]), notice: '不適切なコメントを非表示にしました'
    elsif @post_comment.is_deleted == true
      @post_comment.update(is_deleted: false)
      redirect_to admin_post_path(params[:post_id]), notice: 'コメントを復活させました'
    else
      redirect_to root_path
    end
  end

  def destroy
    @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @post_comment.destroy
    redirect_to admin_post_path(params[:post_id]), notice: 'コメントを削除しました'
  end
end
