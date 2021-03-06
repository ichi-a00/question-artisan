class AddFavoritesCountToQuestions < ActiveRecord::Migration[5.2]
  def self.up
    add_column :questions, :favorites_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :questions, :favorites_count
  end
end
