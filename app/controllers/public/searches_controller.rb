class Public::SearchesController < ApplicationController
  before_action :authenticate_member!

  # 検索内容に応じて、表示する順番も指定しています。
  def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]
    # クリエイター＝メンバー検索
    if @range == "クリエイター"
        @members = Member.looks(params[:search], params[:word]).page(params[:page]).per(15)
    elsif @range == "イラスト"
      @posts = Post.looks(params[:search], params[:word]).latest
      if params[:old]
         @posts = Post.looks(params[:search], params[:word]).old
      else
        @posts = Post.looks(params[:search], params[:word]).latest
      end
        @posts = @posts.page(params[:page])
    else
      tags = Tag.looks(params[:search], params[:word])
      # タグに紐づいた投稿を取り出す(flatten：配列を整える。uniq：レコードの重複を防ぐ)
      post_ids = tags.map { |tag| tag.posts.pluck(:id) }.flatten.uniq
      @posts = Post.where(id: post_ids).latest
      if params[:old]
        @posts = Post.where(id: post_ids).old
      else
        @posts = Post.where(id: post_ids).latest
      end
        @posts = @posts.page(params[:page])
    end
  end
end
