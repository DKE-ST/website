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

ActiveRecord::Schema.define(version: 0) do

  create_table "brothers_dke", force: true do |t|
    t.string  "uname",     limit: 8
    t.text    "pname",               null: false
    t.text    "project",             null: false
    t.text    "big",                 null: false
    t.text    "littles",             null: false
    t.text    "cur_pos",             null: false
    t.text    "past_pos",            null: false
    t.text    "residence",           null: false
    t.integer "p_class",             null: false
  end

  add_index "brothers_dke", ["uname"], name: "uname", unique: true, using: :btree

  create_table "brothers_mit", force: true do |t|
    t.string  "uname",            limit: 8
    t.string  "majors",           limit: 10, null: false
    t.string  "minors",           limit: 10, null: false
    t.string  "concentration",    limit: 20, null: false
    t.text    "extracurriculars",            null: false
    t.text    "interests",                   null: false
    t.text    "urops",                       null: false
    t.text    "internships",                 null: false
    t.text    "fav_classes",                 null: false
    t.integer "year",                        null: false
  end

  add_index "brothers_mit", ["uname"], name: "uname", unique: true, using: :btree

  create_table "brothers_personal", force: true do |t|
    t.string "uname",        limit: 8,  default: "", null: false
    t.text   "last_name",                            null: false
    t.text   "first_name",                           null: false
    t.string "phone",        limit: 13,              null: false
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

end
