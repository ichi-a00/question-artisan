class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :authentication_keys => [:nickname]
  devise :registerable, :recoverable, :rememberable, :validatable


  validates :nickname, uniqueness: true, length: { in: 1..20 }
  validates :introduction, length: { maximum: 50 }

  attachment :image
end
