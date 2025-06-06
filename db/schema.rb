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

ActiveRecord::Schema[8.0].define(version: 2025_06_04_083338) do
  create_table "accounts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "account_number", null: false
    t.string "account_type", null: false
    t.decimal "balance", precision: 15, scale: 2, default: "0.0"
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_number"], name: "index_accounts_on_account_number", unique: true
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "arc_accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "role", null: false
    t.string "account_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_number"], name: "index_arc_accounts_on_account_number", unique: true
    t.index ["confirmation_token"], name: "index_arc_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_arc_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_arc_accounts_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_arc_accounts_on_unlock_token", unique: true
  end

  create_table "loans", force: :cascade do |t|
    t.integer "account_id", null: false
    t.decimal "principal_amount", null: false
    t.decimal "interest_rate", null: false
    t.integer "term_months", null: false
    t.string "status", null: false
    t.datetime "approved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_loans_on_account_id"
  end

  create_table "login_logs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address", null: false
    t.text "user_agent", null: false
    t.boolean "successful", default: false, null: false
    t.datetime "logged_in_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_login_logs_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "from_id", null: false
    t.integer "to_id", null: false
    t.decimal "amount", precision: 15, scale: 2, null: false
    t.string "transaction_type", null: false
    t.string "status", default: "pending", null: false
    t.string "reference_code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_id"], name: "index_transactions_on_from_id"
    t.index ["to_id"], name: "index_transactions_on_to_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "loans", "accounts"
  add_foreign_key "login_logs", "users"
  add_foreign_key "transactions", "accounts", column: "from_id"
  add_foreign_key "transactions", "accounts", column: "to_id"
end
