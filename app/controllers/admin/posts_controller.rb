class Admin::PostsController < ApplicationController
  def index
    if params[:latest]
      @posts = Post.latest
    elsif params[:old]
      @posts = Post.old
    elsif params[:star_latest]
      @posts = Post.star_latest
    elsif params[:star_old]
      @posts = Post.star_old
    else
      @posts = Post.all
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
