# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20240213121925) do

  create_table "cooks", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
  end

  add_index "cooks", ["email"], :name => "index_cooks_on_email", :unique => true

  create_table "orders", :force => true do |t|
    t.string   "order_status",     :null => false
    t.string   "address",          :null => false
    t.integer  "quantity_ordered", :null => false
    t.datetime "delivery_time",    :null => false
    t.integer  "product_id",       :null => false
    t.integer  "user_id",          :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "name",          :null => false
    t.string   "food_type",     :null => false
    t.string   "quantity_type", :null => false
    t.integer  "quantity",      :null => false
    t.integer  "stock",         :null => false
    t.integer  "cook_id",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "price"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "mobile_number"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "is_admin"
    t.string   "email"
  end

  add_index "users", ["mobile_number"], :name => "mobile_number_UNIQUE", :unique => true

end
