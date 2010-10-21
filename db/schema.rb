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

ActiveRecord::Schema.define(:version => 20100928132743) do

  create_table "comparaciones", :force => true do |t|
    t.string   "archivo1"
    t.string   "archivo2"
    t.string   "url1"
    t.string   "url2"
    t.text     "data1"
    t.text     "data2"
    t.string   "codigo"
    t.string   "email"
    t.integer  "idioma_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comparaciones", ["idioma_id"], :name => "index_comparaciones_on_idioma_id"

  create_table "idiomas", :force => true do |t|
    t.string "nombre"
  end

end
