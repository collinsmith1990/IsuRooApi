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

ActiveRecord::Schema.define(version: 20161127195642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidate_matches", force: :cascade do |t|
    t.integer  "candidate_id",                         null: false
    t.integer  "match_id",                             null: false
    t.string   "reply",        limit: 1, default: "p", null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["candidate_id", "match_id"], name: "index_candidate_matches_on_candidate_id_and_match_id", unique: true, using: :btree
    t.index ["candidate_id"], name: "index_candidate_matches_on_candidate_id", using: :btree
    t.index ["match_id"], name: "index_candidate_matches_on_match_id", using: :btree
  end

  create_table "candidates", force: :cascade do |t|
    t.integer "user_id",                                 null: false
    t.integer "rating",                   default: 1500
    t.integer "games_played",             default: 0,    null: false
    t.string  "gender",       limit: 1,   default: "m",  null: false
    t.string  "biography",    limit: 500
    t.index ["user_id"], name: "index_candidates_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string  "content",      null: false
    t.integer "candidate_id", null: false
    t.index ["candidate_id"], name: "index_photos_on_candidate_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string "username",        null: false
    t.string "email",           null: false
    t.string "password_digest", null: false
    t.index "lower((email)::text)", name: "unique_email_on_users", unique: true, using: :btree
    t.index "lower((username)::text)", name: "unique_username_on_users", unique: true, using: :btree
  end

end
