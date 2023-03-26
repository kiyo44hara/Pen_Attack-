class Public::PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :is_matching_login_member, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    tag_list = params[:post][:name].split(',')
    # tag_list = 投稿の中身全てと、タグの名前。詳細はpostモデルを参照してください。
    if @post.save
       @post.save_tag(tag_list)
      redirect_to member_path(current_member), notice: "作品を投稿しました！"
    else
      render:new
    end
  end

  def show
      @post = Post.find(params[:id])
      if @post.member.is_deleted == true
        redirect_to root_path, notice: '既に退会済みのメンバーです！'
      end
      current_member.view_counts.create(post_id: @post.id)
      @post_tags = @post.tags
      @post_comment = PostComment.new
  end

  def index
    if params[:latest]
      @posts = Post.latest.page(params[:page])
    elsif params[:old]
      @posts = Post.old.page(params[:page])
    else
      @posts = Post.latest.page(params[:page])
    end
  end

  def edit
    @post = Post.find(params[:id])
    # 編集画面にて、新たにタグを追加することも可能にしています。
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])

    tag_list = params[:post][:name].split(',')

    params[:post][:star] = params[:score]

    if @post.update(post_params)
      #↓ もともと投稿につけられてたタグを@oldに格納し、削除しています(編集時にタグを削除した場合のエラー回避)
       @old_relations = PostTag.where(post_id: @post.id)
       @old_relations.each do |relation|
        relation.delete
       end
       @post.save_tag(tag_list)
       redirect_to post_path(@post.id), notice: "作品を編集しました。"
    else
      render:edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to member_path(@post.member.id)
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :appeal_point, :improve_point, :production_time, :unit, :star)
  end

# 投稿者以外の介入を受けた場合、トップページに飛ぶようにしています
  def is_matching_login_member
    post = Post.find(params[:id])
    member_id = post.member_id
    unless member_id == current_member.id
      redirect_to root_path
    end
  end
end
