# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_03_20_151417) do
  create_table "pub_sub_clients", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pub_sub_deliveries", force: :cascade do |t|
    t.integer "pub_sub_message_id", null: false
    t.integer "pub_sub_client_id", null: false
    t.boolean "success"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "callback_url"
    t.index ["pub_sub_client_id"], name: "index_pub_sub_deliveries_on_pub_sub_client_id"
    t.index ["pub_sub_message_id"], name: "index_pub_sub_deliveries_on_pub_sub_message_id"
  end

  create_table "pub_sub_keys", force: :cascade do |t|
    t.integer "pub_sub_client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "key"
    t.index ["pub_sub_client_id"], name: "index_pub_sub_keys_on_pub_sub_client_id"
  end

  create_table "pub_sub_messages", force: :cascade do |t|
    t.integer "pub_sub_topic_id", null: false
    t.integer "pub_sub_client_id", null: false
    t.json "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pub_sub_client_id"], name: "index_pub_sub_messages_on_pub_sub_client_id"
    t.index ["pub_sub_topic_id"], name: "index_pub_sub_messages_on_pub_sub_topic_id"
  end

  create_table "pub_sub_subscriptions", force: :cascade do |t|
    t.string "callback_url", null: false
    t.integer "pub_sub_client_id", null: false
    t.integer "pub_sub_topic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pub_sub_client_id"], name: "index_pub_sub_subscriptions_on_pub_sub_client_id"
    t.index ["pub_sub_topic_id"], name: "index_pub_sub_subscriptions_on_pub_sub_topic_id"
  end

  create_table "pub_sub_topics", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "pub_sub_deliveries", "pub_sub_clients"
  add_foreign_key "pub_sub_deliveries", "pub_sub_messages"
  add_foreign_key "pub_sub_keys", "pub_sub_clients"
  add_foreign_key "pub_sub_messages", "pub_sub_clients"
  add_foreign_key "pub_sub_messages", "pub_sub_topics"
  add_foreign_key "pub_sub_subscriptions", "pub_sub_clients"
  add_foreign_key "pub_sub_subscriptions", "pub_sub_topics"
end
