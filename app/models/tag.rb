class Tag < ApplicationRecord
    has_many :posts
    has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
    # タグが消えた時に、投稿ではなくタグのみが消えるように設定

    # タグ検索
  def self.looks(searches, words)
    if searches == "perfect_match"
      @tag = Tag.where("name LIKE ?", "#{words}%")
    else
      @tag = Tag.where("name LIKE ?", "%#{words}%")
    end
  end
end
