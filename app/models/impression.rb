class Impression < ApplicationRecord
  belongs_to :book
  validates :book_id, presence: true
  validates :content, length: { maximum: 1000 }
end
