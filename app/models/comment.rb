class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :customer
  belongs_to :question
end
