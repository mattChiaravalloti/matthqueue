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

ActiveRecord::Schema.define(version: 20170426184935) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_hash"
    t.boolean  "professor"
    t.integer  "institution_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["institution_id"], name: "index_accounts_on_institution_id"
  end

  create_table "accounts_courses", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "course_id"
    t.boolean  "student"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_accounts_courses_on_account_id"
    t.index ["course_id"], name: "index_accounts_courses_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "institution_id"
    t.string   "semester"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["institution_id"], name: "index_courses_on_institution_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string   "name"
    t.string   "password_hash"
    t.string   "secret"
    t.string   "email_regex"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "oh_queues", force: :cascade do |t|
    t.boolean  "active"
    t.integer  "last_position"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "num_tas"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "oh_time_slot_id"
    t.index ["oh_time_slot_id"], name: "index_oh_queues_on_oh_time_slot_id"
  end

  create_table "oh_time_slots", force: :cascade do |t|
    t.string   "frequency"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "course_id"
    t.integer  "avg_wait_time"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["course_id"], name: "index_oh_time_slots_on_course_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "oh_queue_id"
    t.integer  "position"
    t.integer  "student_id"
    t.integer  "resolver_id"
    t.string   "status"
    t.datetime "resolve_time"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["oh_queue_id"], name: "index_questions_on_oh_queue_id"
    t.index ["resolver_id"], name: "index_questions_on_resolver_id"
    t.index ["student_id"], name: "index_questions_on_student_id"
  end

end
