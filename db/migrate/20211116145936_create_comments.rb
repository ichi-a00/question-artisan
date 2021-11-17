class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :question_id, null: false
      t.integer :customer_id, null: false
      t.text :body

      t.timestamps
    end
  end
end
