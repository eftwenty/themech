class CreateOrdersServices < ActiveRecord::Migration
  def change
    create_table :orders_services, id: false do |t|
      t.belongs_to :order, index: true
      t.belongs_to :service, index: true
    end
  end
end
