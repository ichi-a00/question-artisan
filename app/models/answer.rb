class Answer < ApplicationRecord
  # validates :question_id, presence: true, numericality: { only_integer: true }
  validates :content, presence: true, length: { maximum: 30 }
  validates :is_correct, inclusion: { in: [true, false] }
  # validates :order, numericality: { only_integer: true }

  belongs_to :question

  # csv import
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      answer = find_by(id: row["id"]) || new
      answer.attributes = row.to_hash.slice(*updatable_attributes)
      answer.save(validate: false)
    end
  end

  def self.updatable_attributes
    ['id', 'question_id', 'content', 'is_correct']
  end
end
