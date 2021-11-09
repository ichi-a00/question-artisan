class Question < ApplicationRecord

  validates :customer_id, presence: true, numericality: { only_integer: true }
  validates :title, presence: true, length: { maximum: 20 }
  validates :format, presence: true, numericality: { only_integer: true }
  validates :sentence, length: { maximum: 100 }
  validates :explanation, presence: true, length: { maximum: 100 }

  validates :answered_time, presence: true, numericality: { only_integer: true }
  validates :correct_answered_time, presence: true, numericality: { only_integer: true }

  attachment :question_image
  attachment :answer_image

  belongs_to :customer
end
