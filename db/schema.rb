ActiveRecord::Schema.define(version: 20160712152440) do

  create_table "searches", force: :cascade do |t|
    t.text     "company_list",  default: ""
    t.text     "category_list", default: ""
    t.text     "level_list",    default: ""
    t.text     "location_list", default: ""
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
