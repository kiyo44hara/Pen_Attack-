class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to member_path(current_member)
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :appeal_point, :improve_point, :production_time, :star)
  end
end
