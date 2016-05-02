class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :active
      t.decimal :total_ordered, precision: 8, scale: 3
      t.decimal :discount, precision: 8, scale: 3

      t.timestamps null: false
    end
  end
end
