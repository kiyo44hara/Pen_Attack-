class Admin::SearchesController < ApplicationController

  def search
    @range = params[:range]
    if @range == "クリエイター"
      @members = Member.looks(params[:search], params[:word])
    elsif @range == "イラスト"
      @posts = Post.looks(params[:search], params[:word])
    else
      tags = Tag.looks(params[:search], params[:word])
      post_tags = PostTag.where(tag_id: tags.pluck(:id))
      @posts = Post.find(post_tags.pluck(:post_id))
    end
  end
end
