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

ActiveRecord::Schema.define(:version => 20120226134911) do

  create_table "oauths", :force => true do |t|
    t.string   "uuid"
    t.string   "app"
    t.string   "key_id"
    t.string   "name"
    t.string   "name2"
    t.string   "memo"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "longin"
    t.string   "email"
    t.string   "name"
    t.string   "remember_token"
    t.string   "crypted_password"
    t.string   "salt"
    t.text     "description"
    t.datetime "remember_token_expires_at"
    t.datetime "last_contacted_at"
    t.datetime "last_logged_in_at"
    t.integer  "pics_count",                :default => 0, :null => false
    t.integer  "picks_count",               :default => 0, :null => false
    t.string   "email_verified"
    t.string   "avatar"
    t.string   "status"
    t.string   "admin"
    t.string   "email_verified_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pic_tags", :force => true do |t|
    t.string   "pic_id"
    t.string   "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "picconnects", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "picks", :force => true do |t|
    t.string   "user"
    t.string   "ip"
    t.string   "subject"
    t.string   "win_pic_id"
    t.string   "loss_pic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pics", :force => true do |t|
    t.string   "keyname"
    t.string   "subject"
    t.string   "title"
    t.string   "description"
    t.string   "image_url"
    t.string   "original_pic"
    t.string   "bmiddle_pic"
    t.string   "thumbnail_pic"
    t.integer  "scores"
    t.integer  "wins"
    t.integer  "losses"
    t.string   "tmptags"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "link"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
