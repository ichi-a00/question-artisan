class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.integer :question_id, null: false
      t.string :content,      null: false
      t.boolean :is_correct,  null: false, default: false
      t.string :order

      t.timestamps
    end
  end
end
