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

ActiveRecord::Schema[7.1].define(version: 2024_12_04_171952) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.bigint "local_id"
    t.string "name"
    t.integer "status"
    t.string "deviceable_type"
    t.bigint "deviceable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deviceable_type", "deviceable_id"], name: "index_devices_on_deviceable"
    t.index ["local_id"], name: "index_devices_on_local_id"
  end

  create_table "locals", force: :cascade do |t|
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "poses", force: :cascade do |t|
    t.bigint "local_id"
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "deviceable_type", null: false
    t.bigint "deviceable_id", null: false
    t.index ["deviceable_type", "deviceable_id"], name: "index_poses_on_deviceable"
    t.index ["local_id"], name: "index_poses_on_local_id"
  end

  create_table "printers", force: :cascade do |t|
    t.bigint "local_id"
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "deviceable_type", null: false
    t.bigint "deviceable_id", null: false
    t.index ["deviceable_type", "deviceable_id"], name: "index_printers_on_deviceable"
    t.index ["local_id"], name: "index_printers_on_local_id"
  end

  create_table "red_systems", force: :cascade do |t|
    t.bigint "local_id"
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "deviceable_type", null: false
    t.bigint "deviceable_id", null: false
    t.index ["deviceable_type", "deviceable_id"], name: "index_red_systems_on_deviceable"
    t.index ["local_id"], name: "index_red_systems_on_local_id"
  end

  create_table "status_logs", force: :cascade do |t|
    t.bigint "device_id"
    t.bigint "local_id"
    t.integer "last_status"
    t.integer "current_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_status_logs_on_device_id"
    t.index ["local_id"], name: "index_status_logs_on_local_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "local_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["local_id"], name: "index_users_on_local_id"
  end

  add_foreign_key "poses", "locals"
  add_foreign_key "printers", "locals"
  add_foreign_key "red_systems", "locals"
end
