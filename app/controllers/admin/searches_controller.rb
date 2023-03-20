class Admin::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "クリエイター"
        @members = Member.looks(params[:search], params[:word]).page(params[:page])
    elsif @range == "イラスト"
      if params[:old]
        @posts = Post.looks(params[:search], params[:word]).old.page(params[:page])
      else
        @posts = Post.looks(params[:search], params[:word]).latest.page(params[:page])
      end
    else
      @tag = Tag.find_by(name: params[:word])
      if params[:old]
        @posts = @tag.posts.page(params[:page]).old
      else
        @posts = @tag.posts.page(params[:page]).latest
      end
    end
  end
end
