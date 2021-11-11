class Question < ApplicationRecord

  validates :customer_id, presence: true, numericality: { only_integer: true }
  validates :title, presence: true, length: { maximum: 20 }
  validates :format, presence: true
  validates :sentence, length: { maximum: 100 }
  validates :explanation, presence: true, length: { maximum: 100 }

  validates :answered_time, presence: true, numericality: { only_integer: true }
  validates :correct_answered_time, presence: true, numericality: { only_integer: true }

  attachment :question_image
  attachment :answer_image

  enum format: {
    bool: 0,          # ○×
    choose_one: 1,    # 択一
    choose_multi: 2,  # 一文多答
    writing: 3,       # 記述
    #letter_sort: 4,  # ならべかえ
    #order: 5,        # 順番あて
    #panel: 6,        # パネル(=一文多答&順番あて)
  }

  belongs_to :customer
  has_many :answers, dependent: :destroy
end
