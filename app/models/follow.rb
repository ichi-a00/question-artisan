class Follow < ApplicationRecord
  belongs_to :following, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"
end
