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

ActiveRecord::Schema.define(:version => 20120426115849) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "encounters", :force => true do |t|
    t.integer  "user_id",                     :null => false
    t.integer  "other_user_id",               :null => false
    t.string   "interest_type", :limit => 32, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "encounters", ["interest_type"], :name => "index_encounters_on_interest_type"
  add_index "encounters", ["other_user_id"], :name => "index_encounters_on_other_user_id"
  add_index "encounters", ["user_id", "other_user_id"], :name => "index_encounters_on_user_id_and_other_user_id", :unique => true
  add_index "encounters", ["user_id"], :name => "index_encounters_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",                  :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.boolean  "admin",                               :default => false
    t.integer  "age"
    t.string   "gender",                 :limit => 8
  end

  add_index "users", ["admin"], :name => "index_users_on_admin"
  add_index "users", ["age"], :name => "index_users_on_age"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["gender"], :name => "index_users_on_gender"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
