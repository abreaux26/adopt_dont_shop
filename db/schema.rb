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

ActiveRecord::Schema.define(version: 2021_02_18_063032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applicants", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "good_home_description"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pet_applicants", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "applicant_id"
    t.integer "adoption_status", default: 0
    t.index ["applicant_id"], name: "index_pet_applicants_on_applicant_id"
    t.index ["pet_id", "applicant_id"], name: "index_pet_applicants_on_pet_id_and_applicant_id", unique: true
    t.index ["pet_id"], name: "index_pet_applicants_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.integer "approximate_age"
    t.bigint "shelter_id"
    t.string "description"
    t.boolean "adoptable", default: true
    t.integer "sex"
    t.index ["shelter_id"], name: "index_pets_on_shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
  end

  add_foreign_key "pet_applicants", "applicants"
  add_foreign_key "pet_applicants", "pets"
  add_foreign_key "pets", "shelters"
end
