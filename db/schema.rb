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

ActiveRecord::Schema.define(version: 20140717183032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: true do |t|
    t.integer  "song_kick_id"
    t.string   "display_name"
    t.boolean  "favorite",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "top_track"
    t.string   "seatgeek_url"
  end

  create_table "artists_festivals", id: false, force: true do |t|
    t.integer "festival_id", null: false
    t.integer "artist_id",   null: false
  end

  create_table "festivals", force: true do |t|
    t.integer  "song_kick_id"
    t.string   "display_name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "city_name"
    t.float    "lat"
    t.float    "lng"
    t.float    "popularity"
    t.string   "url"
    t.string   "playlist_url"
    t.boolean  "favorite",     default: false
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fest_icon"
    t.string   "tickets_url"
  end

  create_table "users", force: true do |t|
  end

end
