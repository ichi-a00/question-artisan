class Question < ApplicationRecord

  validates :customer_id, presence: true, numericality: { only_integer: true }
  validates :title, presence: true, length: { maximum: 20 }
  validates :format, presence: true
  validates :sentence, presence: true, length: { maximum: 100 }
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
  counter_culture :customer

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  #同時に登録する用(非推奨ではある)
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank

  #tag
  acts_as_taggable

  #閲覧数
  is_impressionable counter_cache: true

  def correct_answer_rate
    if self.answered_time == 0
      0
    else
      (self.correct_answered_time/self.answered_time.to_f*100).floor
    end
  end

  def correct_answers
    self.answers.where(is_correct: true)
  end

  def result?(customer)
    #n+1問題対策
    self.results.map(&:customer_id).include?(customer.id)
  end

  def favorited_by?(customer)
    #n+1問題対策
    self.favorites.map(&:customer_id).include?(customer.id)
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

  def self.search(content, column)
    if content
      case column
        when "nickname"
          where(['customers.nickname LIKE(?)', "%#{content}%"])
        when "title"
          where(['title LIKE(?)', "%#{content}%"])
        when "tag"
          left_joins(:customer, :tags).where(['tags.name LIKE ?', "%#{content}%"])
        else
          left_joins(:customer, :tags).where(['title LIKE(?) OR customers.nickname LIKE(?) OR tags.name LIKE ?', "%#{content}%", "%#{content}%", "%#{content}%"]).distinct
      end
    else
      order(id: "desc")
    end
  end

end
