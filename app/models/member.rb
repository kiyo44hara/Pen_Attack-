class Member < ApplicationRecord
  # アソシエーション
  has_many :posts
  has_many :yells, dependent: :destroy
  has_many :yelled_posts, through: :yells, source: :post
  has_many :post_comments, dependent: :destroy
  has_many :view_counts, dependent: :destroy

  # バリデーション
  validates :name, {presence: true, uniqueness: true, length: {maximum:10}}
  validates :introduction, {length: {maximum:300}}
  validates :is_deleted, inclusion: { in: [true, false] }


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# プロフィール画像の設定
  has_one_attached :profile_image

  # プロフィール画像未設定or設定済み
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/javascript/images/no-image.png')
      profile_image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png' )
    end
      profile_image.variant(resize_to_fill: [width, height]).processed
  end

  # ゲストログインの設定
  def self.guest
    find_or_create_by!(name: 'guestmember', email: 'guest1@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "guestmember"
    end
  end

  # 退会メンバーがログインできないように設定
  def active_for_authentication?
    super && (is_deleted == false)
  end

  # メンバー検索
  def self.looks(searches, words)
    if searches == "perfect_match"
      @member = Member.where("name LIKE ?", "#{words}")
    else
        @member = Member.where("name LIKE ?", "%#{words}%")
    end
  end
end
