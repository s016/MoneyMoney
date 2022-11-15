# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_13_063611) do

  create_table "actual_moneies", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "money_place_id", null: false
    t.date "date", null: false
    t.integer "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["money_place_id"], name: "index_actual_moneies_on_money_place_id"
    t.index ["user_id"], name: "index_actual_moneies_on_user_id"
  end

  create_table "detail_items", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "income_or_payment", null: false
    t.index ["item_id"], name: "index_detail_items_on_item_id"
    t.index ["user_id"], name: "index_detail_items_on_user_id"
  end

  create_table "income_and_payments", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.bigint "detail_item_id", null: false
    t.bigint "money_place_id", null: false
    t.date "date", null: false
    t.boolean "month_loop", default: false, null: false
    t.integer "amount", null: false
    t.integer "income_or_payment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["detail_item_id"], name: "index_income_and_payments_on_detail_item_id"
    t.index ["item_id"], name: "index_income_and_payments_on_item_id"
    t.index ["money_place_id"], name: "index_income_and_payments_on_money_place_id"
    t.index ["user_id"], name: "index_income_and_payments_on_user_id"
  end

  create_table "items", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "income_or_payment", null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "money_places", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.date "date", null: false
    t.integer "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_money_places_on_user_id"
  end

  create_table "results", charset: "utf8mb4", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "actual_moneies", "money_places"
  add_foreign_key "actual_moneies", "users"
  add_foreign_key "detail_items", "items"
  add_foreign_key "detail_items", "users"
  add_foreign_key "income_and_payments", "detail_items"
  add_foreign_key "income_and_payments", "items"
  add_foreign_key "income_and_payments", "money_places"
  add_foreign_key "income_and_payments", "users"
  add_foreign_key "items", "users"
  add_foreign_key "money_places", "users"
end
