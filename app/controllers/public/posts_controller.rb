class Public::PostsController < ApplicationController
  before_action :is_matching_login_member, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:name].split(',')
    # tag_list = 投稿の中身全てと、タグの名前。詳細はpostモデルを参照してください。
    if @post.save
       @post.save_tag(tag_list)
      redirect_to member_path(current_member)
    else
      render:new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
    # 編集画面にて、新たにタグを追加することも可能にしています。
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)
      #↓ もともと投稿につけられてたタグを@oldに格納し、削除しています(編集時にタグを削除した場合のエラー回避)
       @old_relations = PostTag.where(post_id: @post.id)
       @old_relations.each do |relation|
        relation.delete
       end
       @post.save_tag(tag_list)
       redirect_to post_path(@post.id)
    else
      render:edit
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :appeal_point, :improve_point, :production_time, :star)
  end

# 投稿者以外の介入を受けた場合、トップページに飛ぶようにしています
  def is_matching_login_member
    post = Post.find(params[:id])
    member_id = post.member_id
    unless member_id == current_member
      redirect_to root_path
    end
  end
end
