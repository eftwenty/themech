class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :make
      t.string :model
      t.string :status
      t.decimal :total_price

      t.timestamps null: false
    end
  end
end
