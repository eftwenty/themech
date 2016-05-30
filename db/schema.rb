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

ActiveRecord::Schema.define(version: 20160530215846) do

  create_table "customers", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.boolean  "active",                 limit: 1
    t.decimal  "total_ordered",                      precision: 8, scale: 3
    t.decimal  "discount",                           precision: 8, scale: 3
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.string   "email",                  limit: 255,                         default: "", null: false
    t.string   "encrypted_password",     limit: 255,                         default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,                           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.boolean  "completed",              limit: 1
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree
  add_index "customers", ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree

  create_table "emails", force: :cascade do |t|
    t.string   "address",        limit: 255
    t.integer  "emailable_id",   limit: 4
    t.string   "emailable_type", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "emails", ["emailable_type", "emailable_id"], name: "index_emails_on_emailable_type_and_emailable_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "customer_id", limit: 4
    t.string   "make",        limit: 255
    t.string   "model",       limit: 255
    t.string   "status",      limit: 255
    t.decimal  "total_price",             precision: 10
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "orders", ["status"], name: "index_orders_on_status", using: :btree

  create_table "orders_services", id: false, force: :cascade do |t|
    t.integer "order_id",   limit: 4
    t.integer "service_id", limit: 4
  end

  add_index "orders_services", ["order_id"], name: "index_orders_services_on_order_id", using: :btree
  add_index "orders_services", ["service_id"], name: "index_orders_services_on_service_id", using: :btree

  create_table "orders_users", id: false, force: :cascade do |t|
    t.integer "order_id", limit: 4
    t.integer "user_id",  limit: 4
  end

  add_index "orders_users", ["order_id"], name: "index_orders_users_on_order_id", using: :btree
  add_index "orders_users", ["user_id"], name: "index_orders_users_on_user_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string  "number",         limit: 255
    t.boolean "primary",        limit: 1
    t.integer "phoneable_id",   limit: 4
    t.string  "phoneable_type", limit: 255
  end

  add_index "phones", ["phoneable_type", "phoneable_id"], name: "index_phones_on_phoneable_type_and_phoneable_id", using: :btree

  create_table "services", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "man_hours",              precision: 8, scale: 3
    t.decimal  "price",                  precision: 8, scale: 3
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.boolean  "pending",    limit: 1
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "status",                 limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
