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
  counter_culture :customer

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #設問と答えを同時に登録する用(非推奨ではある)
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  #tag
  acts_as_taggable

  #閲覧数
  is_impressionable counter_cache: true

  def correct_answer_rate
    (self.correct_answered_time/self.answered_time.to_f*100).floor
  end

  def correct_answers
    self.answers.where(is_correct: true)
  end

  def result?(customer)
    results.where(customer_id: customer.id).exists?
  end

  def favorited_by?(customer)
    favorites.where(customer_id: customer.id).exists?
  end

  #csv import
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      question = find_by(id: row["id"]) || new
      question.attributes = row.to_hash.slice(*updatable_attributes)
      question.save!(validate: false)
    end
  end

  def self.updatable_attributes
    ['id', 'customer_id', 'title', 'sentence', 'format', 'explanation']
  end

  def self.search(content)
    if content
      left_joins(:customer, :tags).where(['title LIKE(?) OR customers.nickname LIKE(?) OR tags.name LIKE ?', "%#{content}%", "%#{content}%", "%#{content}%"]).distinct
      #binding.pry
    else
      all
    end
  end

end
