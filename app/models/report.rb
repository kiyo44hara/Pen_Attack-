class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Member"
  belongs_to :reported, class_name: "Member"

  validates :reason, { presence: true }

  # 対応待ち、確認中、確認済み
  enum status: { waiting: 0, confirming: 1, finish: 2 }
end
