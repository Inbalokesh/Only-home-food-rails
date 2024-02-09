class CreateCooks < ActiveRecord::Migration
  def change
    create_table :cooks, id: false do |t|
      t.integer :id, auto_increment: true
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
