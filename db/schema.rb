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

ActiveRecord::Schema.define(version: 2018_09_09_102325) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "hp"
    t.integer "attack_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "selfie_url"
    t.integer "agility"
  end

  create_table "fights", force: :cascade do |t|
    t.bigint "first_fighter_id"
    t.bigint "second_fighter_id"
    t.bigint "winner_id"
    t.bigint "loser_id"
    t.string "fight_history", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "p1_weapon"
    t.string "p2_weapon"
    t.index ["first_fighter_id"], name: "index_fights_on_first_fighter_id"
    t.index ["loser_id"], name: "index_fights_on_loser_id"
    t.index ["second_fighter_id"], name: "index_fights_on_second_fighter_id"
    t.index ["winner_id"], name: "index_fights_on_winner_id"
  end

end
