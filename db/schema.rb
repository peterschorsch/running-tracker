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

ActiveRecord::Schema.define(version: 2020_12_30_032257) do

  create_table "all_time_totals", force: :cascade do |t|
    t.decimal "mileage_total", null: false
    t.integer "number_of_runs", null: false
    t.integer "elevation_gain", null: false
    t.integer "time_in_seconds", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_all_time_totals_on_user_id"
  end

  create_table "monthly_totals", force: :cascade do |t|
    t.date "month_start", null: false
    t.date "month_end", null: false
    t.decimal "mileage_total", null: false
    t.integer "number_of_runs", null: false
    t.integer "elevation_gain", null: false
    t.integer "time_in_seconds", null: false
    t.boolean "frozen_flag", default: false
    t.integer "yearly_total_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_monthly_totals_on_user_id"
    t.index ["yearly_total_id"], name: "index_monthly_totals_on_yearly_total_id"
  end

  create_table "obligation_colors", force: :cascade do |t|
    t.string "name", null: false
    t.string "hex_code", limit: 7, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "obligations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.string "city", null: false
    t.boolean "event_flag", default: true
    t.integer "state_id"
    t.integer "user_id"
    t.integer "obligation_color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["obligation_color_id"], name: "index_obligations_on_obligation_color_id"
    t.index ["state_id"], name: "index_obligations_on_state_id"
    t.index ["user_id"], name: "index_obligations_on_user_id"
  end

  create_table "race_distances", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "numeric_distance", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "race_examples", force: :cascade do |t|
    t.string "name", null: false
    t.integer "time_in_seconds", null: false
    t.string "pace_minutes", limit: 2, null: false
    t.string "pace_seconds", limit: 2, null: false
    t.string "elevation_gain", null: false
    t.string "city", null: false
    t.integer "state_id"
    t.integer "race_distance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_distance_id"], name: "index_race_examples_on_race_distance_id"
    t.index ["state_id"], name: "index_race_examples_on_state_id"
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
    t.decimal "planned_mileage", null: false
    t.decimal "mileage_total", default: "0.0"
    t.string "pace_minutes", limit: 2, null: false
    t.string "pace_seconds", limit: 2, null: false
    t.integer "time_in_seconds", null: false
    t.integer "elevation_gain", null: false
    t.string "city", null: false
    t.text "notes"
    t.boolean "personal_best", default: false
    t.boolean "completed_run", default: false
    t.boolean "event_flag", default: false
    t.integer "run_type_id"
    t.integer "shoe_id"
    t.integer "state_id"
    t.integer "monthly_total_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["monthly_total_id"], name: "index_runs_on_monthly_total_id"
    t.index ["run_type_id"], name: "index_runs_on_run_type_id"
    t.index ["shoe_id"], name: "index_runs_on_shoe_id"
    t.index ["state_id"], name: "index_runs_on_state_id"
    t.index ["user_id"], name: "index_runs_on_user_id"
  end

  create_table "shoe_brands", force: :cascade do |t|
    t.string "brand", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shoes", force: :cascade do |t|
    t.string "model", null: false
    t.string "color_way", null: false
    t.string "image_file_name", null: false
    t.string "image_content_type", null: false
    t.bigint "image_file_size", null: false
    t.datetime "image_updated_at", null: false
    t.decimal "forefoot_stack", null: false
    t.decimal "heel_stack", null: false
    t.string "heel_drop", limit: 4, null: false
    t.string "weight", limit: 4, null: false
    t.string "size", limit: 4, null: false
    t.string "shoe_type", null: false
    t.decimal "previous_mileage", default: "0.0"
    t.decimal "new_mileage", default: "0.0"
    t.decimal "total_mileage", default: "0.0"
    t.boolean "default", default: false
    t.date "purchased_on", null: false
    t.date "first_used_on"
    t.boolean "retired", default: false
    t.date "retired_on"
    t.integer "user_id"
    t.integer "shoe_brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shoe_brand_id"], name: "index_shoes_on_shoe_brand_id"
    t.index ["user_id"], name: "index_shoes_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.string "abbreviation", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "administrator", default: false
    t.boolean "user", default: false
    t.boolean "website_viewer", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "time_zone", default: "UTC"
    t.boolean "active", default: true
    t.datetime "last_login"
    t.string "users"
    t.string "password_digest"
    t.integer "user_role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_role_id"], name: "index_users_on_user_role_id"
  end

  create_table "weekly_totals", force: :cascade do |t|
    t.date "week_start", null: false
    t.date "week_end", null: false
    t.decimal "mileage_total", default: "0.0", null: false
    t.decimal "mileage_goal", precision: 5, scale: 5, default: "0.0"
    t.boolean "met_goal", default: false
    t.integer "time_in_seconds", null: false
    t.integer "number_of_runs", null: false
    t.integer "elevation_gain", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_weekly_totals_on_user_id"
  end

  create_table "yearly_totals", force: :cascade do |t|
    t.string "year", limit: 4, null: false
    t.date "year_start", null: false
    t.date "year_end", null: false
    t.decimal "mileage_total", null: false
    t.integer "number_of_runs", null: false
    t.integer "elevation_gain", null: false
    t.integer "time_in_seconds", null: false
    t.boolean "frozen_flag", default: false
    t.integer "all_time_total_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["all_time_total_id"], name: "index_yearly_totals_on_all_time_total_id"
    t.index ["user_id"], name: "index_yearly_totals_on_user_id"
  end

end
