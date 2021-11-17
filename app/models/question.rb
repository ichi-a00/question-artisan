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
    #panel: 6,        # パネル()
  }

  belongs_to :customer
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #設問と答えを同時に登録する用(非推奨ではある)
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  #tag
  acts_as_taggable

  def correct_answers
    self.answers.where(is_correct: true)
  end

  def result?(customer)
    results.where(customer_id: customer.id).exists?
  end

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

end
