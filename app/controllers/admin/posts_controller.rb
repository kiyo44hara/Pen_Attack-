class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:latest]
      @posts = Post.latest.page(params[:page])
    elsif params[:old]
      @posts = Post.old.page(params[:page])
    else
      @posts = Post.latest.page(params[:page])
    end

  end

  def show
    @post = Post.find (params[:id])
    @post_tags = @post.tags
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
