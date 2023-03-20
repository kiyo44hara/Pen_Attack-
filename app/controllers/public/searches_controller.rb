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
      @tag = Tag.find_by(name: params[:word])
      if !@tag.present?
        @posts = Kaminari.paginate_array([]).page(params[:page])
      elsif params[:old]
        @posts = @tag.posts.old.page(params[:page])
      else
        @posts = @tag.posts.latest.page(params[:page])
      end
    end
  end
end
