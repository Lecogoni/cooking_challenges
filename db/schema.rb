# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_25_204206) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "challenges", force: :cascade do |t|
    t.string "title", default: ""
    t.string "status", default: "pending"
    t.string "description", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "numb_guest"
    t.string "meal_category"
    t.string "meal_area"
    t.string "theme_choice"
  end

  create_table "events", force: :cascade do |t|
    t.string "status", default: "unscheduled"
    t.string "role", default: "participant"
    t.bigint "user_id"
    t.bigint "challenge_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "participation", default: "pending"
    t.integer "total_event", default: 0
    t.index ["challenge_id"], name: "index_events_on_challenge_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "username", default: ""
    t.string "email"
    t.bigint "challenge_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["challenge_id"], name: "index_guests_on_challenge_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "label"
    t.integer "grade", default: 0
    t.bigint "survey_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.bigint "event_id"
    t.string "idMeal"
    t.string "meal"
    t.string "drinkAlternate"
    t.string "category"
    t.string "area"
    t.text "instructions"
    t.string "mealThumb"
    t.string "tags"
    t.string "youtube"
    t.string "ingredient1"
    t.string "ingredient2"
    t.string "ingredient3"
    t.string "ingredient4"
    t.string "ingredient5"
    t.string "ingredient6"
    t.string "ingredient7"
    t.string "ingredient8"
    t.string "ingredient9"
    t.string "ingredient10"
    t.string "ingredient11"
    t.string "ingredient12"
    t.string "ingredient13"
    t.string "ingredient14"
    t.string "ingredient15"
    t.string "ingredient16"
    t.string "ingredient17"
    t.string "ingredient18"
    t.string "ingredient19"
    t.string "ingredient20"
    t.string "measure1"
    t.string "measure2"
    t.string "measure3"
    t.string "measure4"
    t.string "measure5"
    t.string "measure6"
    t.string "measure7"
    t.string "measure8"
    t.string "measure9"
    t.string "measure10"
    t.string "measure11"
    t.string "measure12"
    t.string "measure13"
    t.string "measure14"
    t.string "measure15"
    t.string "measure16"
    t.string "measure17"
    t.string "measure18"
    t.string "measure19"
    t.string "measure20"
    t.string "source"
    t.string "imageSource"
    t.string "creativeCommonsConfirmed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_recipes_on_event_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "surveyor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "total_grade", default: 0
    t.string "status", default: "pending"
    t.string "comment"
    t.string "challenge_id"
    t.index ["event_id"], name: "index_surveys_on_event_id"
    t.index ["surveyor_id"], name: "index_surveys_on_surveyor_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "challenges"
  add_foreign_key "events", "users"
  add_foreign_key "guests", "challenges"
  add_foreign_key "questions", "surveys"
  add_foreign_key "surveys", "events"
end
