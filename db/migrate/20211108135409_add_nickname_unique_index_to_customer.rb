class AddNicknameUniqueIndexToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_index :customers, :nickname, unique: true
  end
end
