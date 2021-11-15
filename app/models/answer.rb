class Answer < ApplicationRecord

  #validates :question_id, presence: true, numericality: { only_integer: true }
  validates :content, presence: true, length: { maximum: 30 }
  validates :is_correct, inclusion: {in: [true, false]}
  #validates :order, numericality: { only_integer: true }

  belongs_to :question
end
