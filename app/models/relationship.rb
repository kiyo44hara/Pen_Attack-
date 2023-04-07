class Relationship < ApplicationRecord
  belongs_to :member
  belongs_to :follower, class_name: 'Member'
end
