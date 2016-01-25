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

ActiveRecord::Schema.define(version: 20151030232833) do

  create_table "calendar_events", force: true do |t|
    t.string   "title"
    t.text     "desc"
    t.integer  "brother_id"
    t.string   "color"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chapter_house_points", force: true do |t|
    t.integer  "dke_info_id"
    t.integer  "officer_id"
    t.float    "value"
    t.string   "comment"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chapter_officers", force: true do |t|
    t.string   "name"
    t.text     "title"
    t.integer  "position"
    t.integer  "dke_info_id"
    t.boolean  "assign_points"
    t.datetime "start_date"
    t.boolean  "disp"
    t.text     "contact"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chapter_public_pages", force: true do |t|
    t.string   "pname"
    t.integer  "officer_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chapter_residences", force: true do |t|
    t.string   "name"
    t.integer  "floor"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "epsilon_e_sheets", force: true do |t|
    t.integer  "dke_info_id"
    t.date     "date"
    t.string   "time",        limit: 8
    t.string   "e_type",      limit: 8
    t.float    "value"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "summer_housing_applications", force: true do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.string   "sex"
    t.integer  "age"
    t.string   "email"
    t.string   "phone"
    t.string   "school"
    t.integer  "year"
    t.string   "dke_brother"
    t.text     "q1"
    t.text     "q2"
    t.text     "q3"
    t.text     "q4"
    t.text     "q5"
    t.text     "q6"
    t.text     "q7"
    t.text     "q8"
    t.integer  "room_pref"
    t.string   "finding"
    t.boolean  "lived_before"
    t.boolean  "car"
    t.boolean  "contacted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_brother_dke_infos", force: true do |t|
    t.integer  "brother_id"
    t.text     "p_name"
    t.text     "project"
    t.text     "past_pos"
    t.integer  "big_id"
    t.integer  "residence_id"
    t.integer  "p_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "meal_plan",    default: false
  end

  create_table "user_brother_mit_infos", force: true do |t|
    t.integer  "brother_id"
    t.string   "mit_id",           limit: 9
    t.text     "majors"
    t.text     "minors"
    t.text     "concentration"
    t.text     "extracurriculars"
    t.text     "interests"
    t.text     "urops"
    t.text     "internships"
    t.text     "fav_classes"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_brother_mit_infos", ["mit_id"], name: "index_user_brother_mit_infos_on_mit_id", unique: true, using: :btree

  create_table "user_brothers", force: true do |t|
    t.integer  "user_id"
    t.text     "first_name"
    t.text     "last_name"
    t.string   "phone",        limit: 10
    t.text     "email"
    t.text     "bio"
    t.text     "activities"
    t.text     "hobbies"
    t.text     "pro_team"
    t.text     "college_team"
    t.text     "movie"
    t.text     "quote"
    t.text     "hometown"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_shadows", primary_key: "uname", force: true do |t|
    t.integer  "user_id"
    t.text     "passwd",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "uname",      limit: 8,              null: false
    t.integer  "status",                default: 0
    t.string   "group",      limit: 9,              null: false
    t.string   "chicken",    limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["uname"], name: "index_users_on_uname", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",                         null: false
    t.integer  "item_id",                           null: false
    t.string   "event",                             null: false
    t.string   "whodunnit"
    t.text     "object",         limit: 2147483647
    t.datetime "created_at"
    t.text     "object_changes", limit: 2147483647
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
