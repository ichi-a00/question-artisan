class Follow < ApplicationRecord
  belongs_to :following, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"

  # N+1問題対策。followは特殊なためcolumn_name指定しないとうまくいかない(followsとか探しに行く)
  counter_culture :following, class_name: "Customer", column_name: "following_count"
  counter_culture :followed, class_name: "Customer", column_name: "followed_count"
end
