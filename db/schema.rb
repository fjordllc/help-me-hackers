# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100629094108) do

  create_table "comments", :force => true do |t|
    t.integer  "task_id",                        :null => false
    t.integer  "user_id",                        :null => false
    t.text     "description",                    :null => false
    t.boolean  "correct",     :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "countries", ["name"], :name => "index_countries_on_name", :unique => true

  create_table "editors", :force => true do |t|
    t.string "name"
  end

  add_index "editors", ["name"], :name => "index_editors_on_name", :unique => true

  create_table "languages", :force => true do |t|
    t.string "name", :null => false
    t.string "kind", :null => false
  end

  add_index "languages", ["name"], :name => "index_languages_on_name", :unique => true

  create_table "licenses", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "licenses", ["name"], :name => "index_licenses_on_name", :unique => true

  create_table "projects", :force => true do |t|
    t.string   "name",            :null => false
    t.text     "description"
    t.text     "website_url"
    t.text     "repository_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "logo_image_url"
  end

  add_index "projects", ["name"], :name => "index_projects_on_name", :unique => true

  create_table "states", :force => true do |t|
    t.string  "name",       :null => false
    t.integer "country_id"
  end

  add_index "states", ["name"], :name => "index_states_on_name"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title",                      :null => false
    t.text     "description",                :null => false
    t.integer  "user_id",                    :null => false
    t.integer  "language_id",                :null => false
    t.integer  "license_id",                 :null => false
    t.integer  "bounty",      :default => 0, :null => false
    t.integer  "view",        :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.text     "source_url"
  end

  create_table "users", :force => true do |t|
    t.integer  "twitter_id"
    t.string   "login"
    t.string   "access_token"
    t.string   "access_secret"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.text     "description"
    t.string   "profile_image_url"
    t.string   "url"
    t.integer  "utc_offset"
    t.string   "time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "state_id"
    t.integer  "language_id"
    t.string   "company"
    t.string   "github_account"
    t.text     "ssh_public_key"
    t.integer  "reputation",                :default => 0,    :null => false
    t.boolean  "hacker",                    :default => true, :null => false
    t.boolean  "hackee",                    :default => true, :null => false
    t.string   "bitbucket_account"
    t.integer  "editor_id"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => true, :null => false
    t.string   "comment"
    t.integer  "voteable_id",                     :null => false
    t.string   "voteable_type",                   :null => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "voted_user_id"
  end

end
