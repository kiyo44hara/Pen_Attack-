class Public::HomesController < ApplicationController
  before_action :authenticate_member!

  def top
    @posts = Post.limit(10).latest
  end
end
