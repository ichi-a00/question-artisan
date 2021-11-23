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

  #customer.followingはFollowテーブルのfollowing_idを参照して、followテーブルのデータを返す
  has_many :following, class_name:"Follow", foreign_key:"following_id", dependent: :destroy
  #customer.followedはFollowテーブルのfollowed_idを参照して、followテーブルのデータを返す
  has_many :followed, class_name:"Follow", foreign_key:"followed_id", dependent: :destroy

  #customer.followsは"customerがフォローしてる人"一覧　ツイッターでいうフォロー一覧 customerテーブルのデータを返す
  has_many :following_customers, through: :following, source: :followed
  #customer.followersは"customerをフォローしてる人"一覧　ツイッターでいうフォロワー一覧　customerテーブルのデータを返す
  has_many :followed_customers, through: :followed, source: :following

  def next_rank_exp
    self.exp_to - self.experience_point
  end

  def next_rank_percent
    100*(1-self.next_rank_exp/(self.exp_to - self.exp_from).to_f)
  end

  def following?(customer)
    #n+1問題対応
    self.following_customers.map(&:id).include?(customer.id)
  end

  def rankup?
    if self.exp_to <= self.experience_point
      #探してきたレコードの閾値よりもユーザーの総経験値が高かった場合レベルを1増やして更新
      self.rank += 1
      self.exp_from = Rank.find_by(rank: self.rank).experience_point
      self.exp_to = Rank.find_by(rank: self.rank+1).experience_point
      self.save!
    else
      return false
    end
  end
end
