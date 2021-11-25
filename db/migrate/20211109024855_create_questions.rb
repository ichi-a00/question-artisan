class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :customer_id,           null: false
      t.string  :title,                 null: false
      t.text    :sentence,              null: false
      t.integer :format,                null: false
      t.text    :explanation,           null: false, default: ""
      t.string  :question_image_id,     null: false, default: ""
      t.string  :answer_image_id,       null: false, default: ""
      t.integer :answered_time,         null: false, default: 0
      t.string  :correct_answered_time, null: false, default: 0

      t.timestamps
    end
  end
end