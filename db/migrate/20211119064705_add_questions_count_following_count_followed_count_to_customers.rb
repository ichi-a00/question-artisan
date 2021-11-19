class AddQuestionsCountFollowingCountFollowedCountToCustomers < ActiveRecord::Migration[5.2]
  def self.up
    add_column :customers, :questions_count, :integer, null: false, default: 0

    add_column :customers, :following_count, :integer, null: false, default: 0

    add_column :customers, :followed_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :customers, :questions_count

    remove_column :customers, :following_count

    remove_column :customers, :followed_count
  end
end
