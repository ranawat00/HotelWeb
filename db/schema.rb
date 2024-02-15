
ActiveRecord::Schema[7.1].define(version: 2024_02_15_090340) do
  create_table "addresses", force: :cascade do |t|
    t.string "house_no"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "zip_code"
    t.integer "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_addresses_on_property_id"
  end

  create_table "categories", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "source"
    t.integer "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_images_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "no_bedrooms"
    t.integer "no_baths"
    t.integer "no_beds"
    t.float "area"
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_properties_on_category_id"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "reservation_criteria", force: :cascade do |t|
    t.text "time_period"
    t.float "others_fee"
    t.integer "min_time_period"
    t.integer "max_guest"
    t.float "rate"
    t.integer "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_reservation_criteria_on_property_id"
  end

  create_table "reversations", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "guests"
    t.decimal "price", precision: 10, scale: 2
    t.integer "user_id", null: false
    t.integer "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_reversations_on_property_id"
    t.index ["user_id"], name: "index_reversations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "name", null: false
    t.string "role", default: "user", null: false
    t.string "avatar", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "address", "properties", on_delete: :cascade
  add_foreign_key "images", "properties", on_delete: :cascade
  add_foreign_key "properties", "categories", on_delete: :cascade
  add_foreign_key "properties", "users", on_delete: :cascade
  add_foreign_key "reservation_criteria", "properties", on_delete: :cascade
  add_foreign_key "reversations", "properties", on_delete: :cascade
  add_foreign_key "reversations", "users", on_delete: :cascade
end
