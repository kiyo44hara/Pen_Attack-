class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find (params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
  end
end
