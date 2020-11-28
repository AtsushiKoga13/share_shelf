class User < ApplicationRecord
  mount_uploader :avatar, UserUploader
  has_many :books, dependent: :destroy
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :avatar, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts, dependent: :destroy

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def create_book_post(user, book_name, book_image)
    posts.create(
      content: "#{user.name}さんが「#{book_name}」を本棚に登録しました。",
      image: book_image,
      name: user.name,
      post_type: 2 # フォローユーザーの書籍追加通知
    )
  end

  def create_follow_post(follower)
    posts.create(
      content: "#{follower.name}さんにフォローされました。",
      image: follower.avatar.url,
      name: follower.name,
      post_type: 1 # フォロー通知
    )
  end
end
