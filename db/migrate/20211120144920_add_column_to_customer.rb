class AddColumnToCustomer < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :exp_from, :integer, default: 0
    add_column :customers, :exp_to, :integer, default: 2
  end
end
