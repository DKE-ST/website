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

ActiveRecord::Schema.define(version: 20140319041822) do

  create_table "brothers_dke", force: true do |t|
    t.string  "uname",     limit: 8
    t.text    "pname",                               null: false
    t.text    "project",                             null: false
    t.text    "big",                                 null: false
    t.text    "littles",                             null: false
    t.text    "past_pos",                            null: false
    t.text    "residence",                           null: false
    t.integer "p_class",                             null: false
    t.boolean "meal_plan",           default: false, null: false
  end

  add_index "brothers_dke", ["uname"], name: "uname", unique: true, using: :btree

  create_table "brothers_mit", force: true do |t|
    t.string  "uname",            limit: 8
    t.string  "majors",           limit: 10, default: "", null: false
    t.string  "minors",           limit: 10, default: "", null: false
    t.string  "concentration",    limit: 20, default: "", null: false
    t.text    "extracurriculars",                         null: false
    t.text    "interests",                                null: false
    t.text    "urops",                                    null: false
    t.text    "internships",                              null: false
    t.text    "fav_classes",                              null: false
    t.integer "year",                                     null: false
  end

  add_index "brothers_mit", ["uname"], name: "uname", unique: true, using: :btree

  create_table "brothers_personal", force: true do |t|
    t.string "uname",        limit: 8,  default: "", null: false
    t.text   "last_name",                            null: false
    t.text   "first_name",                           null: false
    t.string "phone",        limit: 10, default: "", null: false
    t.text   "bio",                                  null: false
    t.text   "activities",                           null: false
    t.text   "hobbies",                              null: false
    t.text   "pro_team",                             null: false
    t.text   "college_team",                         null: false
    t.text   "movie",                                null: false
    t.text   "quote",                                null: false
    t.text   "hometown",                             null: false
  end

  add_index "brothers_personal", ["uname"], name: "uname", unique: true, using: :btree

  create_table "chapter_public", force: true do |t|
    t.string "pname",   limit: 10
    t.string "user",    limit: 10
    t.text   "title",              null: false
    t.text   "content",            null: false
  end

  add_index "chapter_public", ["pname"], name: "pname", unique: true, using: :btree

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "e_menu", force: true do |t|
    t.string "day",    limit: 9, null: false
    t.text   "lunch",            null: false
    t.text   "dinner",           null: false
  end

  create_table "e_sheets", force: true do |t|
    t.date   "date",                           null: false
    t.string "time",    limit: 7,              null: false
    t.string "e_type",  limit: 8,              null: false
    t.string "uname",   limit: 8, default: "", null: false
    t.float  "value",                          null: false
    t.text   "comment",                        null: false
  end

  add_index "e_sheets", ["date"], name: "date", using: :btree

  create_table "house_points", force: true do |t|
    t.string "uname",    limit: 8, null: false
    t.text   "position",           null: false
    t.float  "value",              null: false
    t.text   "comment",            null: false
    t.date   "date",               null: false
  end

  create_table "house_rooms", force: true do |t|
    t.integer "floor",               null: false
    t.text    "name",                null: false
    t.integer "capacity",            null: false
    t.string  "occupant0", limit: 8
    t.string  "occupant1", limit: 8
    t.string  "occupant2", limit: 8
    t.string  "occupant3", limit: 8
  end

  create_table "positions", force: true do |t|
    t.text    "position",                               null: false
    t.text    "name",                                   null: false
    t.string  "uname",        limit: 8,                 null: false
    t.date    "start_date",                             null: false
    t.boolean "exec",                   default: false, null: false
    t.boolean "award_points",           default: false, null: false
    t.boolean "disp",                   default: false, null: false
    t.text    "contact",                                null: false
  end

  create_table "settings", primary_key: "name", force: true do |t|
    t.text "val",  limit: 255, null: false
    t.text "desc"
  end

  create_table "summer_apps", primary_key: "ID", force: true do |t|
    t.text    "first_name",              null: false
    t.text    "last_name",               null: false
    t.text    "email",                   null: false
    t.string  "phone",        limit: 10, null: false
    t.text    "school",                  null: false
    t.integer "year",                    null: false
    t.text    "dke_brother",             null: false
    t.text    "q1",                      null: false
    t.text    "q2",                      null: false
    t.text    "q3",                      null: false
    t.text    "q4",                      null: false
    t.text    "q5",                      null: false
    t.text    "q6",                      null: false
    t.text    "q7",                      null: false
    t.text    "q8",                      null: false
    t.text    "q9",                      null: false
    t.text    "q10",                     null: false
    t.integer "room_pref",               null: false
    t.string  "finding",      limit: 11, null: false
    t.boolean "lived_before",            null: false
    t.boolean "car",                     null: false
    t.date    "date",                    null: false
  end

end
