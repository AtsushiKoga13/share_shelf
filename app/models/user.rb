class User < ApplicationRecord
  # has_one_attached :image
  mount_uploader :avatar, UserUploader
  has_many :books, dependent: :destroy
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }
  # validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
  #                                     message: "must be a valid image format" },
  #                     size:         { less_than: 5.megabytes,
  #                                     message: "should be less than 5MB" }
end
