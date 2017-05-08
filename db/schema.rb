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

ActiveRecord::Schema.define(version: 20170324010342) do

  create_table "books", force: :cascade do |t|
    t.text     "book_name",     limit: 65535
    t.integer  "book_quantity", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "request_id", limit: 4
    t.string   "content",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "request_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.integer  "book_id",          limit: 4
    t.integer  "status",           limit: 4
    t.integer  "quantity",         limit: 4
    t.float    "book_price",       limit: 24
    t.text     "book_link",        limit: 65535
    t.datetime "date_approve"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.text     "image_link",       limit: 65535
    t.integer  "quantity_of_like", limit: 4
    t.string   "admin_comment",    limit: 255
  end

  add_index "requests", ["book_id"], name: "index_requests_on_book_id", using: :btree
  add_index "requests", ["user_id"], name: "index_requests_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.text     "user_pwd",   limit: 65535
    t.text     "user_name",  limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_foreign_key "requests", "books"
  add_foreign_key "requests", "users"
end
