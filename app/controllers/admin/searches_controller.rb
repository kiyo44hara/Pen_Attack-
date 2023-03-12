class Admin::SearchesController < ApplicationController
  def search
    @range = params[:range]
    if @range == 'クリエイター'
      @members = Member.looks(params[:search], params[:word])
    elsif @range == 'イラスト名'
      @posts = Post.looks(params[:search], params[:word])
    else
      @tags = Tag.looks(params[:search], params[:word])
    end
  end
end
