class ViewCount < ApplicationRecord
  belongs_to :member
  belongs_to :post
end
