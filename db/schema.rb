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

ActiveRecord::Schema.define(:version => 20100208203056) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "games", :force => true do |t|
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.integer  "tournament_id"
    t.integer  "game_result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tournaments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "nick"
    t.string   "last_commit_sha"
    t.integer  "wins",            :default => 0
    t.integer  "losses",          :default => 0
    t.integer  "draws",           :default => 0
    t.integer  "games_played",    :default => 0
    t.float    "score",           :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "repo_name"
    t.string   "repo_url"
    t.boolean  "active",          :default => false
  end

end
