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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140219100853) do

  create_table "line_items", force: true do |t|
    t.integer  "pet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pet_items", force: true do |t|
    t.integer  "pet_id"
    t.integer  "pet_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pet_items", ["pet_id"], name: "index_pet_items_on_pet_id"
  add_index "pet_items", ["pet_list_id"], name: "index_pet_items_on_pet_list_id"

  create_table "pet_lists", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pets", force: true do |t|
    t.string   "name"
    t.string   "breed"
    t.string   "image_url"
    t.integer  "age"
    t.boolean  "shots"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
