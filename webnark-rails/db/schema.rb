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

ActiveRecord::Schema.define(version: 20130904213353) do

  create_table "answers", force: true do |t|
    t.integer  "service_id"
    t.integer  "report_choice_id"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "selected"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "report_categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "icon_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_choices", force: true do |t|
    t.integer  "report_item_id"
    t.string   "name"
    t.boolean  "bonus"
    t.integer  "points"
    t.text     "description"
    t.text     "help"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_items", force: true do |t|
    t.integer  "report_category_id"
    t.string   "name"
    t.text     "help"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "slug"
    t.string   "hosting_provider"
    t.string   "country"
    t.string   "screenshot_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "score"
    t.datetime "score_updated_at"
  end
  add_index :services, :slug, unique: true

end
