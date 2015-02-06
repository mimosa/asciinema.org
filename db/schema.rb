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

ActiveRecord::Schema.define(version: 8) do

  create_table "accounts", force: true do |t|
    t.string   "email",               limit: 128
    t.string   "mobile",              limit: 128
    t.string   "name",                limit: 16
    t.string   "username",            limit: 16
    t.string   "single_access_token", limit: 128, null: false
    t.string   "temporary_username"
    t.string   "theme_name"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "reset_token"
    t.datetime "reset_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["email"], name: "index_accounts_on_email", using: :btree
  add_index "accounts", ["single_access_token"], name: "index_accounts_on_single_access_token", using: :btree
  add_index "accounts", ["username"], name: "index_accounts_on_username", using: :btree

  create_table "asciicasts", force: true do |t|
    t.uuid     "user_id"
    t.string   "title"
    t.float    "duration",         limit: 24,                 null: false
    t.string   "terminal_type"
    t.integer  "terminal_columns",                            null: false
    t.integer  "terminal_lines",                              null: false
    t.string   "command"
    t.string   "shell"
    t.string   "uname"
    t.boolean  "featured",                    default: false
    t.boolean  "time_compression",            default: true,  null: false
    t.string   "stdin_data"
    t.string   "stdin_timing"
    t.string   "stdout_data"
    t.string   "stdout_timing"
    t.string   "stdout_frames"
    t.integer  "likes_count",                 default: 0,     null: false
    t.integer  "views_count",                 default: 0,     null: false
    t.integer  "comments_count",              default: 0,     null: false
    t.text     "description"
    t.text     "snapshot"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_agent"
    t.string   "theme_name"
    t.float    "snapshot_at",      limit: 24
  end

  add_index "asciicasts", ["created_at"], name: "index_asciicasts_on_created_at", using: :btree
  add_index "asciicasts", ["featured"], name: "index_asciicasts_on_featured", using: :btree
  add_index "asciicasts", ["likes_count"], name: "index_asciicasts_on_likes_count", using: :btree
  add_index "asciicasts", ["user_id"], name: "asciicasts_user_id_fk", using: :btree

  create_table "authorizations", force: true do |t|
    t.uuid     "user_id"
    t.string   "provider",   limit: 128, null: false
    t.string   "uid",        limit: 128, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["provider", "uid"], name: "index_authorizations_on_provider_and_uid", using: :btree
  add_index "authorizations", ["user_id"], name: "authorizations_user_id_fk", using: :btree

  create_table "comments", force: true do |t|
    t.text     "body",         null: false
    t.uuid     "user_id",      null: false
    t.uuid     "asciicast_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["asciicast_id"], name: "comments_asciicast_id_fk", using: :btree
  add_index "comments", ["user_id"], name: "comments_user_id_fk", using: :btree

  create_table "devices", force: true do |t|
    t.uuid     "udid",       null: false
    t.uuid     "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["user_id"], name: "devices_user_id_fk", using: :btree

  create_table "expiring_tokens", force: true do |t|
    t.uuid     "user_id",                null: false
    t.string   "token",      limit: 128, null: false
    t.datetime "expires_at",             null: false
    t.datetime "used_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "expiring_tokens", ["used_at", "expires_at", "token"], name: "index_expiring_tokens_on_used_at_and_expires_at_and_token", using: :btree
  add_index "expiring_tokens", ["user_id"], name: "expiring_tokens_user_id_fk", using: :btree

  create_table "likes", force: true do |t|
    t.uuid     "user_id",      null: false
    t.uuid     "asciicast_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["asciicast_id"], name: "likes_asciicast_id_fk", using: :btree
  add_index "likes", ["user_id"], name: "likes_user_id_fk", using: :btree

  create_table "sidekiq_jobs", force: true do |t|
    t.string   "jid",         limit: 128
    t.string   "queue",       limit: 128
    t.string   "class_name",  limit: 128
    t.text     "args"
    t.boolean  "retry"
    t.datetime "enqueued_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string   "status",      limit: 16
    t.string   "name"
    t.text     "result"
  end

  add_index "sidekiq_jobs", ["class_name"], name: "index_sidekiq_jobs_on_class_name", using: :btree
  add_index "sidekiq_jobs", ["enqueued_at"], name: "index_sidekiq_jobs_on_enqueued_at", using: :btree
  add_index "sidekiq_jobs", ["finished_at"], name: "index_sidekiq_jobs_on_finished_at", using: :btree
  add_index "sidekiq_jobs", ["jid"], name: "index_sidekiq_jobs_on_jid", using: :btree
  add_index "sidekiq_jobs", ["queue"], name: "index_sidekiq_jobs_on_queue", using: :btree
  add_index "sidekiq_jobs", ["retry"], name: "index_sidekiq_jobs_on_retry", using: :btree
  add_index "sidekiq_jobs", ["started_at"], name: "index_sidekiq_jobs_on_started_at", using: :btree
  add_index "sidekiq_jobs", ["status"], name: "index_sidekiq_jobs_on_status", using: :btree

  add_foreign_key "asciicasts", "accounts", name: "asciicasts_user_id_fk", column: "user_id", dependent: :delete

  add_foreign_key "authorizations", "accounts", name: "authorizations_user_id_fk", column: "user_id", dependent: :delete

  add_foreign_key "comments", "accounts", name: "comments_user_id_fk", column: "user_id", dependent: :delete
  add_foreign_key "comments", "asciicasts", name: "comments_asciicast_id_fk", dependent: :delete

  add_foreign_key "devices", "accounts", name: "devices_user_id_fk", column: "user_id", dependent: :delete

  add_foreign_key "expiring_tokens", "accounts", name: "expiring_tokens_user_id_fk", column: "user_id", dependent: :delete

  add_foreign_key "likes", "accounts", name: "likes_user_id_fk", column: "user_id", dependent: :delete
  add_foreign_key "likes", "asciicasts", name: "likes_asciicast_id_fk", dependent: :delete

end
