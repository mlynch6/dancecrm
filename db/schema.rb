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

ActiveRecord::Schema.define(version: 20150318124241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name",       limit: 100, null: false
    t.string   "subdomain",  limit: 50,  null: false
    t.integer  "owner_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "accounts", ["owner_id"], name: "index_accounts_on_owner_id", using: :btree

  create_table "contacts_people", force: :cascade do |t|
    t.integer  "account_id",                            null: false
    t.string   "type"
    t.string   "first_name",  limit: 30,                null: false
    t.string   "middle_name", limit: 30
    t.string   "last_name",   limit: 30,                null: false
    t.string   "suffix",      limit: 10
    t.string   "gender",      limit: 10
    t.date     "birth_date"
    t.string   "email",       limit: 50
    t.boolean  "active",                 default: true, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "contacts_people", ["account_id"], name: "index_contacts_people_on_account_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "account_id",                 null: false
    t.string   "email",           limit: 50, null: false
    t.string   "password_digest",            null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree

end
