class Public::HomesController < ApplicationController

  def top
    @posts = Post.limit(10).latest
  end
end
