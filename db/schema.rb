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

ActiveRecord::Schema.define(version: 20140407075206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "text"
    t.string   "link"
    t.date     "happens_at"
    t.integer  "user_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_id"
  end

  add_index "events", ["twitter_id"], name: "index_events_on_twitter_id", using: :btree
  add_index "events", ["user_group_id"], name: "index_events_on_user_group_id", using: :btree

  create_table "user_groups", force: true do |t|
    t.string  "name"
    t.string  "twitter_account"
    t.string  "color",           limit: 7
    t.string  "logo",            limit: 200
    t.string  "website",         limit: 200
    t.string  "description",     limit: 400
    t.string  "facebook_page",   limit: 200
    t.string  "googleplus_page", limit: 200
    t.integer "user_id"
  end

  add_index "user_groups", ["user_id"], name: "index_user_groups_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.boolean  "approved",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
