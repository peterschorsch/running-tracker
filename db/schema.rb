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

ActiveRecord::Schema.define(version: 2020_09_09_050054) do

  create_table "gears", force: :cascade do |t|
    t.string "model", null: false
    t.string "color_way", null: false
    t.string "image_file_name", null: false
    t.string "image_content_type", null: false
    t.bigint "image_file_size", null: false
    t.datetime "image_updated_at", null: false
    t.string "heel_drop", limit: 2, null: false
    t.string "weight", limit: 4, null: false
    t.string "size", limit: 4, null: false
    t.string "shoe_type", null: false
    t.integer "mileage", default: 0
    t.boolean "default", default: false
    t.date "purchased_on", null: false
    t.date "first_used_on"
    t.boolean "retired", default: false
    t.date "retired_on"
    t.integer "shoe_brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shoe_brand_id"], name: "index_gears_on_shoe_brand_id"
  end

  create_table "shoe_brands", force: :cascade do |t|
    t.string "brand", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbreviation", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "role", null: false
    t.boolean "active", default: true
    t.string "users"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
