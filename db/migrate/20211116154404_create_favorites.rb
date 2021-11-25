class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :question_id, null: false
      t.integer :customer_id, null: false

      t.timestamps
    end
  end
end