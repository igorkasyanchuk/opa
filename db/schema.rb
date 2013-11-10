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

ActiveRecord::Schema.define(:version => 0) do

  create_table "businesses", :force => true do |t|
    t.integer "city_id"
    t.string  "name"
    t.float   "price"
    t.string  "schedule",    :limit => 1000
    t.string  "synonims",    :limit => 300
    t.string  "site"
    t.string  "email"
    t.text    "description"
  end

  add_index "businesses", ["city_id"], :name => "businesses_city_id_index"
  add_index "businesses", ["id"], :name => "businesses_id_index"

  create_table "businesses_categories", :id => false, :force => true do |t|
    t.integer "business_id"
    t.integer "category_id"
  end

  add_index "businesses_categories", ["business_id", "category_id"], :name => "businesses_categories_business_id_category_id_index"
  add_index "businesses_categories", ["business_id"], :name => "businesses_categories_business_id_index"

  create_table "businesses_keywords", :id => false, :force => true do |t|
    t.integer "business_id"
    t.integer "keyword_id"
  end

  add_index "businesses_keywords", ["business_id", "keyword_id"], :name => "businesses_keywords_business_id_keyword_id_index"
  add_index "businesses_keywords", ["business_id"], :name => "businesses_keywords_business_id_index"

  create_table "categories", :force => true do |t|
    t.string "name"
  end

  add_index "categories", ["id"], :name => "categories_id_index"

  create_table "cities", :force => true do |t|
    t.string "name"
  end

  add_index "cities", ["id"], :name => "cities_id_index"

  create_table "keywords", :force => true do |t|
    t.string "name"
  end

  add_index "keywords", ["id"], :name => "keywords_id_index"

  create_table "phones_addresses", :force => true do |t|
    t.integer "business_id"
    t.string  "phone"
    t.string  "address"
  end

  add_index "phones_addresses", ["business_id"], :name => "phones_addresses_business_id_index"
  add_index "phones_addresses", ["id"], :name => "phones_addresses_id_index"

end
