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

ActiveRecord::Schema.define(version: 20160125044025) do

  create_table "comments", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.string   "user_name",  limit: 255
    t.text     "text",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "meta", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "category",    limit: 4,     default: 0, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "meta_relations", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.integer  "meta_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.integer  "year",        limit: 4
    t.text     "description", limit: 65535
    t.text     "story",       limit: 65535
    t.integer  "status",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "youtubes", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.string   "youtube_id", limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
