class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.decimal :man_hours, precision: 8, scale: 3
      t.decimal :price, precision: 8, scale: 3

      t.timestamps null: false
    end
  end
end
