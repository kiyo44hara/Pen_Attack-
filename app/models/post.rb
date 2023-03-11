class Post < ApplicationRecord

    has_many :post_tags, dependent: :destroy
    has_many :tags, through: :post_tags
    belongs_to :member

  enum unit: { minutes: 0, time: 1, day: 2 }

  has_one_attached :image

  def get_image(width, height)
    image.variant(resize_to_fill: [width, height]).processed
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
