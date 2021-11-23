class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :question
  #n+1
  counter_culture :question
end
