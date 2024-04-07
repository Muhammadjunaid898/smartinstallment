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

ActiveRecord::Schema.define(version: 2024_03_25_160722) do

  create_table "companies", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.date "creation_date"
    t.integer "admin_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
    t.index ["admin_id", "name"], name: "index_companies_on_admin_id_and_name", unique: true
    t.index ["name"], name: "index_companies_on_name", unique: true
    t.index ["subdomain"], name: "index_companies_on_subdomain", unique: true
  end

  create_table "installment_plans", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "company_id"
    t.integer "booking_amount"
    t.integer "allocation_amount"
    t.integer "bianual_payment"
    t.integer "monthly_payment"
    t.integer "quaterly_payment"
    t.decimal "duration", precision: 4, scale: 2, default: "1.0"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["sequence_num", "company_id"], name: "index_installment_plans_on_sequence_num_and_company_id", unique: true
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "full_name"
    t.integer "company_id"
    t.integer "status", default: 1
    t.integer "created_by_id"
    t.index ["email", "company_id"], name: "index_users_on_email_and_company_id", unique: true
    t.index ["full_name", "company_id"], name: "index_users_on_full_name_and_company_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
