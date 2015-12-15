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

ActiveRecord::Schema.define(version: 20151214195048) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "articles", force: :cascade do |t|
    t.string   "title",      null: false
    t.text     "text",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  add_index "articles", ["title"], name: "index_articles_on_title"
  add_index "articles", ["user_id"], name: "index_articles_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "article_id", null: false
    t.text     "text",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["article_id", "user_id"], name: "index_comments_on_article_id_and_user_id"
  add_index "comments", ["article_id"], name: "index_comments_on_article_id"
  add_index "comments", ["user_id", "article_id"], name: "index_comments_on_user_id_and_article_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "histories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "histories", ["article_id"], name: "index_histories_on_article_id"
  add_index "histories", ["user_id", "article_id"], name: "index_histories_on_user_id_and_article_id"
  add_index "histories", ["user_id"], name: "index_histories_on_user_id"

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stars", force: :cascade do |t|
    t.integer  "article_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stars", ["article_id"], name: "index_stars_on_article_id"
  add_index "stars", ["user_id"], name: "index_stars_on_user_id"

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "provider",    default: "", null: false
    t.string   "uid",                      null: false
    t.string   "screen_name", default: "", null: false
    t.string   "name",        default: "", null: false
    t.string   "image"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  add_index "users", ["screen_name"], name: "index_users_on_screen_name", unique: true

end
