class PostComment < ApplicationRecord
  belongs_to :member
  belongs_to :post

  validates :comment, {presence: true, length: {maximum:200}}
  validates :is_deleted, inclusion: { in: [true, false] }
end
