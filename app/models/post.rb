class Post < ApplicationRecord
  # アソシエーション
    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    has_many :yells, dependent: :destroy
    has_many :yelled_members, through: :yells, source: :member
    has_many :post_comments, dependent: :destroy
    has_many :view_counts, dependent: :destroy
    belongs_to :member

  # バリデーション
    validates :image, {presence: true}
    validates :title, {presence: true, length: {maximum:15}}
    validates :body, {presence: true, length: {maximum:300}}
    validates :appeal_point, {presence: true, length: {maximum:100}}
    validates :improve_point, {presence: true, length: {maximum:100}}
    validates :star, {presence: true}

  # 制作時間の単位をそれぞれ、分・時間・日で分けています。
  enum unit: { minutes: 0, time: 1, day: 2 }

  # 投稿並び替え機能(一覧用))
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_latest, -> { order(star: :desc)}
  scope :star_old, -> { order(star: :asc)}

  # 応援した投稿を並び替える機能(不具合)
  # scope :yell_latest, -> { joins(:yells).order('yells.created_at DESC')}
  # scope :yell_old, -> { joins(:yells).order('yells.created_at ASC')}

  # 投稿イラスト設定
  has_one_attached :image

  # 画像を省略して表示したい場合
  def get_image(width, height)
    image.variant(resize_to_fill: [width, height]).processed
  end
  # 画像をフルサイズで表示したい場合
  def get_imege_full(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end


  # 応援機能の作成と削除のメソッド
  def yelled_by?(member)
    yells.exists?(member_id: member.id)
  end

  # 投稿タイトル検索
  def self.looks(searches, words)
    if searches == "perfect_match"
      @post = Post.where("title LIKE ?", "#{words}")
    else
      @post = Post.where("title LIKE ?", "%#{words}%")
    end
  end



# 複数タグを取り扱う為のメソッドです(postsコントローラーのcreate参照)
# 既存のタグを除いて、新しいタグのみ保存されるように記述しています。
  def save_tag(sent_tags)
    #pluckメソッドを使い、存在するタグを全て取得
      current_tags = self.tags.pluck(:name) unless self.tags.nil?
    #もともと存在していたタグをold_tagsと命名
      old_tags = current_tags - sent_tags
    #新しいタグをnew_tagsと命名
      new_tags = sent_tags - current_tags

    #古いタグを消す(タグモデルから情報を取得し、削除)
    old_tags.each do |old|
        self.tags.delete Tag.find_by(name: old)
    end

    #新しいタグを保存(タグモデルに新たにレコード作成＆保存する)
    new_tags.each do |new|
        new_post_tag = Tag.find_or_create_by(name: new)
        self.tags << new_post_tag
    end
  end


end
