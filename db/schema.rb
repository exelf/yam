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

ActiveRecord::Schema.define(version: 20160201065434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cols", force: :cascade do |t|
    t.string   "name",       limit: 8, null: false
    t.integer  "coef",                 null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "combinations", force: :cascade do |t|
    t.string   "name",       limit: 7, null: false
    t.integer  "max_score",            null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "gamblings", force: :cascade do |t|
    t.integer  "game_id",                    null: false
    t.integer  "user_id",                    null: false
    t.boolean  "is_over",    default: false, null: false
    t.integer  "score"
    t.jsonb    "data"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "games", force: :cascade do |t|
    t.boolean  "is_over",    default: false, null: false
    t.jsonb    "data"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "guests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "time_zone",       null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "rolls", force: :cascade do |t|
    t.integer  "gambling_id",                    null: false
    t.jsonb    "d1",                             null: false
    t.jsonb    "d2"
    t.jsonb    "d3"
    t.integer  "memor"
    t.string   "kept"
    t.integer  "n",              default: 1,     null: false
    t.boolean  "is_over",        default: false, null: false
    t.integer  "col_id"
    t.integer  "combination_id"
    t.integer  "score"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "player_type",                                                                null: false
    t.integer  "player_id",                                                                  null: false
    t.jsonb    "data",        default: {"colors"=>["e11414", "e1e114", "14e114", "7a14e1"]}, null: false
    t.datetime "created_at",                                                                 null: false
    t.datetime "updated_at",                                                                 null: false
  end

end
