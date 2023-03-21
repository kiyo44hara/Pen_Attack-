class Public::SearchesController < ApplicationController

  # 検索内容に応じて、表示する順番も指定しています。
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
      tags = Tag.looks(params[:search], params[:word])
      # タグに紐づいた投稿を取り出す(flatten：配列を整える。uniq：レコードの重複を防ぐ)
      post_ids = tags.map { |tag| tag.posts.pluck(:id) }.flatten.uniq
      if params[:old]
        @posts = Post.where(id: post_ids).old.page(params[:page])
      else
        @posts = Post.where(id: post_ids).latest.page(params[:page])
      end
    end
  end
end
