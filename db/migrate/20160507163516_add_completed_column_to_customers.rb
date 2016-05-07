class AddCompletedColumnToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :completed, :boolean
  end
end
