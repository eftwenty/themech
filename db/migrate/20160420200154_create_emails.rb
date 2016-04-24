class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :address
      t.boolean :primary
      t.references :emailable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
