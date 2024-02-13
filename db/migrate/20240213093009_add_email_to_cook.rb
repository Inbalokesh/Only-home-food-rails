class AddEmailToCook < ActiveRecord::Migration
  def change
    add_column :cooks, :email, :string
    add_index :cooks, :email, unique: true
  end
end
