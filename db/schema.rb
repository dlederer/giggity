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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130401101947) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "colleges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "gigs", :force => true do |t|
    t.integer  "booker_id"
    t.integer  "performer_id"
    t.integer  "price"
    t.boolean  "approved",          :default => false
    t.text     "rider"
    t.date     "date"
    t.string   "location"
    t.boolean  "booker_confirm",    :default => false
    t.boolean  "performer_confirm", :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "status"
    t.time     "time"
    t.integer  "legacy_id"
    t.string   "legacy_class"
  end

  create_table "messages", :force => true do |t|
    t.integer  "to_id"
    t.integer  "from_id"
    t.boolean  "read",         :default => false
    t.string   "content"
    t.integer  "gig_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "legacy_id"
    t.string   "legacy_class"
  end

  create_table "photos", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "row_order"
  end

  create_table "posts", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "legacy_id"
    t.string   "legacy_class"
  end

  create_table "reviews", :force => true do |t|
    t.text     "content"
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "reviewer_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "gig_id"
    t.integer  "legacy_id"
    t.string   "legacy_class"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "songs", :force => true do |t|
    t.integer  "user_id"
    t.string   "embed_code"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.integer  "row_order"
    t.integer  "legacy_id"
    t.string   "legacy_class"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "display_name"
    t.integer  "category_id"
    t.integer  "college_id"
    t.text     "blurb"
    t.boolean  "featured",               :default => false
    t.integer  "score"
    t.integer  "price_min"
    t.integer  "price_max"
    t.string   "subcategory"
    t.string   "username"
    t.integer  "profile_photo_id"
    t.string   "address"
    t.float    "address_longitude"
    t.float    "address_latitude"
    t.integer  "legacy_id"
    t.string   "legacy_class"
  end

  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "videos", :force => true do |t|
    t.integer  "user_id"
    t.string   "embed_code"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "row_order"
    t.integer  "legacy_id"
    t.string   "legacy_class"
  end

end
