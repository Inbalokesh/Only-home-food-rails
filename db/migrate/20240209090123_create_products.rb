class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, id: false do |t|
      t.integer :id, auto_increment: true
      t.string :name
      t.string :food_type
      t.string :quantity_type
      t.integer :quantity
      t.integer :stock
      t.integer :price
      t.references :cook, foreign_key: true

      t.timestamps
    end
  end
end
