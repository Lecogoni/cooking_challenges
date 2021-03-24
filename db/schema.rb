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

ActiveRecord::Schema.define(version: 2021_03_24_145833) do

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

  create_table "meals", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.string "Meal"
    t.string "DrinkAlternate"
    t.string "Category"
    t.string "Area"
    t.text "Instructions"
    t.string "MealThumb"
    t.string "Tags"
    t.string "Youtube"
    t.string "Ingredient1"
    t.string "Ingredient2"
    t.string "Ingredient3"
    t.string "Ingredient4"
    t.string "Ingredient5"
    t.string "Ingredient6"
    t.string "Ingredient7"
    t.string "Ingredient8"
    t.string "Ingredient9"
    t.string "Ingredient10"
    t.string "Ingredient11"
    t.string "Ingredient12"
    t.string "Ingredient13"
    t.string "Ingredient14"
    t.string "Ingredient15"
    t.string "Ingredient16"
    t.string "Ingredient17"
    t.string "Ingredient18"
    t.string "Ingredient19"
    t.string "Ingredient20"
    t.string "Measure1"
    t.string "Measure2"
    t.string "Measure3"
    t.string "Measure4"
    t.string "Measure5"
    t.string "Measure6"
    t.string "Measure7"
    t.string "Measure8"
    t.string "Measure9"
    t.string "Measure10"
    t.string "Measure11"
    t.string "Measure12"
    t.string "Measure13"
    t.string "Measure14"
    t.string "Measure15"
    t.string "Measure16"
    t.string "Measure17"
    t.string "Measure18"
    t.string "Measure19"
    t.string "Measure20"
    t.string "Source"
    t.string "ImageSource"
    t.string "CreativeCommonsConfirmed"
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
    t.index ["event_id"], name: "index_surveys_on_event_id"
    t.index ["surveyor_id"], name: "index_surveys_on_surveyor_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "label"
    t.string "mail"
    t.string "titre"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "travels", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
