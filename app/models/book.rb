class Book < ApplicationRecord
  belongs_to :user
  has_one :tag
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
end
