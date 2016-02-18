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

ActiveRecord::Schema.define(version: 20160218192622) do

  create_table "configurations", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "credits"
    t.string   "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lectures", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "professor_id"
    t.string   "schedule"
    t.date     "semester"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "lectures", ["course_id"], name: "index_lectures_on_course_id"
  add_index "lectures", ["professor_id"], name: "index_lectures_on_professor_id"

  create_table "offerings", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "letter"
    t.string   "schedule"
    t.integer  "professor_id"
    t.date     "semester"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "offerings", ["course_id"], name: "index_offerings_on_course_id"
  add_index "offerings", ["professor_id"], name: "index_offerings_on_professor_id"

  create_table "ourconfigs", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "preferences", force: :cascade do |t|
    t.integer  "professor_id"
    t.integer  "offering_id"
    t.string   "first_major"
    t.string   "second_major"
    t.string   "third_major"
    t.string   "first_service"
    t.string   "second_service"
    t.string   "third_service"
    t.string   "ttc_proposal_1"
    t.string   "ttc_proposal_2"
    t.string   "ttc_proposal_3"
    t.text     "comments"
    t.date     "semester"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "preferences", ["offering_id"], name: "index_preferences_on_offering_id"
  add_index "preferences", ["professor_id"], name: "index_preferences_on_professor_id"

  create_table "professors", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "kind"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

end
