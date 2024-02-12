class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.integer :id, auto_increment: true
      t.string :name
      t.string :mobile_number
      t.string :password_digest

      t.timestamps
    end

    execute "ALTER TABLE users ADD PRIMARY KEY (id);"

  end
end
