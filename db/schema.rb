# encoding: UTF-8

ActiveRecord::Schema.define(version: 20140411172101) do

  enable_extension "plpgsql"

  create_table "chats", force: true do |t|
    t.integer  "contact_id"
    t.string   "client"
    t.string   "handle"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "middle_name"
    t.string   "full_name"
  end

  create_table "demographics", force: true do |t|
    t.integer  "contact_id"
    t.string   "gender"
    t.string   "age"
    t.string   "location_general"
    t.string   "age_range"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "digital_footprints", force: true do |t|
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.integer  "contact_id"
    t.boolean  "is_primary", default: false
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "photos", force: true do |t|
    t.integer  "contact_id"
    t.string   "network_type"
    t.string   "type_name"
    t.string   "url"
    t.boolean  "is_primary",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", force: true do |t|
    t.integer "monthly_limit", default: 25
    t.string  "name"
    t.decimal "price"
  end

  create_table "scores", force: true do |t|
    t.integer  "digital_footprint_id"
    t.string   "provider"
    t.string   "network_type"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "social_profiles", force: true do |t|
    t.integer  "contact_id"
    t.string   "network_type"
    t.string   "type_name"
    t.string   "username"
    t.string   "url"
    t.string   "account_id"
    t.text     "bio"
    t.integer  "followers"
    t.integer  "following"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.integer  "digital_footprint_id"
    t.string   "provider"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                         default: "", null: false
    t.string   "encrypted_password",            default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                 default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "customer_id"
    t.string   "last_4_digits"
    t.string   "name"
    t.boolean  "admin"
    t.integer  "plan_id"
    t.integer  "total_found_emails_count",      default: 0
    t.integer  "found_emails_count_this_cycle", default: 0
    t.integer  "search_attempts_this_cycle",    default: 0
    t.integer  "total_search_attempts",         default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "websites", force: true do |t|
    t.integer  "contact_id"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
