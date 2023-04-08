class Public::SearchesController < ApplicationController
  before_action :authenticate_member!

  # 検索内容に応じて、表示する順番も指定しています(昇順・降順)。
  def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]

  # メンバー検索
    if @range == "クリエイター"
        @members = Member.looks(params[:search], params[:word]).member_latest
        @members = Member.looks(params[:search], params[:word]).member_old if params[:member_old]
        @members = @members.page(params[:page]).per(15)
  # 投稿検索
    elsif @range == "イラスト"
      @posts = Post.looks(params[:search], params[:word]).latest
      @posts = Post.looks(params[:search], params[:word]).old if params[:old]
      @posts = @posts.page(params[:page])
  # タグ検索
    else
      tags = Tag.looks(params[:search], params[:word])
  # タグに紐づいた投稿を取り出す(flatten：配列を整える。uniq：レコードの重複を防ぐ)
      post_ids = tags.map { |tag| tag.posts.pluck(:id) }.flatten.uniq
      @posts = Post.where(id: post_ids).latest
      @posts = Post.where(id: post_ids).old if params[:old]
      @posts = @posts.page(params[:page])
    end
  end
end
