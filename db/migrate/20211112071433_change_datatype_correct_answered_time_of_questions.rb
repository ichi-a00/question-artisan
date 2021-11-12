class ChangeDatatypeCorrectAnsweredTimeOfQuestions < ActiveRecord::Migration[5.2]
  def change
    change_column :questions, :correct_answered_time, :integer
  end
end
