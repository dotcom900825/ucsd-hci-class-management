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

ActiveRecord::Schema.define(version: 20160101195018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assignments", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "due_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "visible",     default: true
    t.boolean  "team_based",  default: false
  end

  create_table "grading_fields", force: true do |t|
    t.string   "name"
    t.integer  "score"
    t.text     "comment"
    t.integer  "submission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rubric_field_id"
  end

  create_table "labs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rubric_fields", force: true do |t|
    t.string   "name"
    t.integer  "assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rubrics", force: true do |t|
    t.integer  "assignment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_labs", force: true do |t|
    t.integer  "student_id"
    t.integer  "lab_id"
    t.boolean  "complete",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_labs", ["student_id", "lab_id"], name: "index_student_labs_on_student_id_and_lab_id", unique: true, using: :btree

  create_table "student_quizzes", force: true do |t|
    t.integer  "student_id"
    t.integer  "quiz_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_quizzes", ["student_id", "quiz_id"], name: "index_student_quizzes_on_student_id_and_quiz_id", unique: true, using: :btree

  create_table "studios", force: true do |t|
    t.string   "location"
    t.string   "theme"
    t.string   "time"
    t.integer  "ta_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "section_num"
    t.integer  "students_count", default: 0
  end

  create_table "submissions", force: true do |t|
    t.integer  "student_id"
    t.integer  "assignment_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "self_assessment_grade",   default: 0
    t.integer  "ta_grade",                default: 0
    t.integer  "sa_points",               default: 0
    t.integer  "final_grade",             default: 0
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "studio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                            null: false
    t.string   "name",                             null: false
    t.string   "type"
    t.string   "pid",                              null: false
    t.string   "crypted_password",                 null: false
    t.string   "salt",                             null: false
    t.integer  "studio_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "college"
    t.string   "year"
    t.string   "major"
    t.boolean  "wait_listed",      default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
