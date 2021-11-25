class AddNameToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :nickname,         :string,  null: false, default: ""
    add_column :customers, :rank,             :integer, null: false, default: 1
    add_column :customers, :experience_point, :integer, null: false, default: 0
    add_column :customers, :image_id,         :string,  null: false, default: ""
    add_column :customers, :is_valid,         :boolean, null: false, default: true
  end
end

