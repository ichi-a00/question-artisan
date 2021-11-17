class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :authentication_keys => [:nickname]
  devise :registerable, :recoverable, :rememberable, :validatable


  validates :nickname, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }
  validates :rank, presence: true, numericality: { only_integer: true }
  validates :experience_point, presence: true, numericality: { only_integer: true }

  attachment :image

  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def next_rank_exp
    Rank.find_by(rank: self.rank+1).experience_point - self.experience_point
  end
end
