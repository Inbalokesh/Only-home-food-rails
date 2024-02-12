class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders, id: false do |t|
      t.integer :id, auto_increment: true

      t.string :order_status
      t.string :address
      t.integer :quantity_ordered
      t.datetime :delivery_time

      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
