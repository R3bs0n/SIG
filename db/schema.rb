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

ActiveRecord::Schema[8.1].define(version: 2026_07_13_154152) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "color", default: "#2563eb", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "kind", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "kind", "name"], name: "index_categories_on_company_id_and_kind_and_name", unique: true
    t.index ["company_id"], name: "index_categories_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "document"
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  create_table "financial_accounts", force: :cascade do |t|
    t.string "account_type", default: "checking", null: false
    t.boolean "active", default: true, null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.decimal "opening_balance", precision: 15, scale: 2, default: "0.0", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_financial_accounts_on_company_id"
  end

  create_table "financial_transactions", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2, null: false
    t.bigint "category_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.date "due_date", null: false
    t.bigint "financial_account_id", null: false
    t.string "kind", null: false
    t.text "notes"
    t.date "paid_at"
    t.string "status", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_financial_transactions_on_category_id"
    t.index ["company_id", "due_date"], name: "index_financial_transactions_on_company_id_and_due_date"
    t.index ["company_id", "kind"], name: "index_financial_transactions_on_company_id_and_kind"
    t.index ["company_id", "status"], name: "index_financial_transactions_on_company_id_and_status"
    t.index ["company_id"], name: "index_financial_transactions_on_company_id"
    t.index ["financial_account_id"], name: "index_financial_transactions_on_financial_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role", default: "admin", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "categories", "companies"
  add_foreign_key "financial_accounts", "companies"
  add_foreign_key "financial_transactions", "categories"
  add_foreign_key "financial_transactions", "companies"
  add_foreign_key "financial_transactions", "financial_accounts"
  add_foreign_key "users", "companies"
end
