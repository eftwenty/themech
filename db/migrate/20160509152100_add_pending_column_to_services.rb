class AddPendingColumnToServices < ActiveRecord::Migration
  def change
    add_column :services, :pending, :boolean
  end
end
