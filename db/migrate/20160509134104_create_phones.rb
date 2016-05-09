class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number
      t.boolean :primary
      t.references :phoneable, polymorphic: true, index: true
    end
  end
end
