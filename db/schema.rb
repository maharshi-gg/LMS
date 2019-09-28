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

ActiveRecord::Schema.define(version: 2019_09_28_220518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_request", force: :cascade do |t|
    t.date "date"
    t.boolean "is_special"
    t.boolean "is_approved"
    t.integer "books_id"
    t.integer "librarians_id"
    t.integer "students_id"
    t.index ["books_id"], name: "index_book_request_on_books_id"
    t.index ["librarians_id"], name: "index_book_request_on_librarians_id"
    t.index ["students_id"], name: "index_book_request_on_students_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.string "author"
    t.string "language"
    t.date "published"
    t.string "edition"
    t.string "image"
    t.string "subject"
    t.text "summary"
    t.boolean "special_collection"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "book_count"
    t.boolean "is_issued"
    t.integer "number_hold_req"
    t.bigint "libraries_id"
    t.index ["libraries_id"], name: "index_books_on_libraries_id"
  end

  create_table "librarians", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "library"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "libraries", force: :cascade do |t|
    t.string "name"
    t.string "university"
    t.string "location"
    t.integer "max_days"
    t.float "fines"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "books_id"
    t.index ["books_id"], name: "index_libraries_on_books_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password"
    t.string "education"
    t.string "university"
    t.integer "max_books"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "university"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "book_request", "books", column: "books_id"
  add_foreign_key "book_request", "librarians", column: "librarians_id"
  add_foreign_key "book_request", "students", column: "students_id"
  add_foreign_key "books", "libraries", column: "libraries_id"
end
