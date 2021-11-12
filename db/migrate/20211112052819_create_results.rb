class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.integer :customer_id, null: false
      t.integer :question_id, null: false
      t.integer :trial_count, null: false, default: 0
      t.boolean :is_cleared, default: false

      t.timestamps
    end
  end
end
