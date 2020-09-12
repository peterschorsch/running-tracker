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

ActiveRecord::Schema.define(version: 2020_09_11_211257) do

  create_table "all_time_totals", force: :cascade do |t|
    t.decimal "mileage_total", null: false
    t.integer "number_of_runs", null: false
    t.integer "elevation_gain", null: false
    t.integer "hours", null: false
    t.integer "minutes", limit: 3, null: false
    t.integer "seconds", limit: 2, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_all_time_totals_on_user_id"
  end

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

  create_table "month_keys", force: :cascade do |t|
    t.integer "number", limit: 1, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monthly_totals", force: :cascade do |t|
    t.string "month_number", limit: 1, null: false
    t.datetime "month_start", null: false
    t.datetime "month_end", null: false
    t.decimal "mileage_total", null: false
    t.integer "hours", null: false
    t.integer "minutes", limit: 3, null: false
    t.integer "seconds", limit: 2, null: false
    t.integer "number_of_runs", null: false
    t.integer "elevation_gain", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "obligations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "start_datetime", null: false
    t.datetime "end_datetime", null: false
    t.string "city", null: false
    t.integer "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_obligations_on_state_id"
  end

  create_table "race_distances", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "distance_miles", precision: 5, scale: 5, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "races", force: :cascade do |t|
    t.string "race", null: false
    t.datetime "race_datetime", null: false
    t.string "hours", limit: 3, null: false
    t.string "minutes", limit: 2, null: false
    t.string "seconds", limit: 2, null: false
    t.string "pace", null: false
    t.text "notes"
    t.string "city", null: false
    t.string "bib_number", null: false
    t.integer "gear_id"
    t.integer "race_distance_id"
    t.integer "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gear_id"], name: "index_races_on_gear_id"
    t.index ["race_distance_id"], name: "index_races_on_race_distance_id"
    t.index ["state_id"], name: "index_races_on_state_id"
  end

  create_table "run_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "hex_code", limit: 7, null: false
    t.boolean "active", default: true
    t.boolean "default", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "runs", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "start_time", null: false
    t.decimal "distance", precision: 5, scale: 5, null: false
    t.string "pace", null: false
    t.integer "hours"
    t.integer "minutes", limit: 3, null: false
    t.integer "seconds", limit: 2, null: false
    t.integer "elevation_gain", null: false
    t.string "avg_heart_rate", limit: 3, null: false
    t.string "max_heart_rate", limit: 3, null: false
    t.string "city", null: false
    t.text "notes"
    t.boolean "personal_best", default: false
    t.integer "run_type_id"
    t.integer "gear_id"
    t.integer "state_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gear_id"], name: "index_runs_on_gear_id"
    t.index ["run_type_id"], name: "index_runs_on_run_type_id"
    t.index ["state_id"], name: "index_runs_on_state_id"
    t.index ["user_id"], name: "index_runs_on_user_id"
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
    t.integer "all_time_totals_id"
    t.index ["all_time_totals_id"], name: "index_users_on_all_time_totals_id"
  end

  create_table "weekly_totals", force: :cascade do |t|
    t.string "week_number", limit: 1, null: false
    t.datetime "week_start", null: false
    t.datetime "week_end", null: false
    t.decimal "mileage_total", null: false
    t.decimal "goal", precision: 5, scale: 5
    t.boolean "met_goal", default: false
    t.integer "hours", null: false
    t.integer "minutes", limit: 3, null: false
    t.integer "seconds", limit: 2, null: false
    t.integer "number_of_runs", null: false
    t.integer "elevation_gain", null: false
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yearly_totals", force: :cascade do |t|
    t.string "year", limit: 4, null: false
    t.datetime "year_start", null: false
    t.datetime "year_end", null: false
    t.decimal "mileage_total", null: false
    t.integer "number_of_runs", null: false
    t.integer "elevation_gain", null: false
    t.integer "hours", null: false
    t.integer "minutes", limit: 3, null: false
    t.integer "seconds", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "all_time_total_id"
    t.index ["all_time_total_id"], name: "index_yearly_totals_on_all_time_total_id"
  end

end
