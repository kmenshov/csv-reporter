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

ActiveRecord::Schema.define(version: 20161108095927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :bigserial, force: :cascade do |t|
    t.string   "fName",      limit: 45, null: false
    t.string   "lName",      limit: 45, null: false
    t.integer  "family_id",             null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "accounts", ["family_id"], name: "index_accounts_on_family_id", using: :btree

  create_table "families", force: :cascade do |t|
    t.string   "familyName", limit: 45, null: false
    t.string   "fEmail",     limit: 45, null: false
    t.integer  "school_id",             null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "families", ["school_id"], name: "index_families_on_school_id", using: :btree

  create_table "merchants", force: :cascade do |t|
    t.string   "mEmail",         limit: 45,                         null: false
    t.string   "mName",          limit: 45,                         null: false
    t.decimal  "commissionRate",            precision: 3, scale: 2, null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "sName",      limit: 45, null: false
    t.string   "sEmail",     limit: 45, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "datetime",                                   null: false
    t.integer  "idTypeTransaction",                          null: false
    t.decimal  "amount",            precision: 13, scale: 2, null: false
    t.integer  "account_id",                                 null: false
    t.integer  "merchant_id"
    t.decimal  "tCommission",       precision: 13, scale: 2
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "transactions", ["account_id"], name: "index_transactions_on_account_id", using: :btree
  add_index "transactions", ["merchant_id"], name: "index_transactions_on_merchant_id", using: :btree

  add_foreign_key "accounts", "families"
  add_foreign_key "families", "schools"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "merchants"
end
