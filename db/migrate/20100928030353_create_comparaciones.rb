class CreateComparaciones < ActiveRecord::Migration
  def self.up
    create_table :comparaciones do |t|
      t.string :archivo1
      t.string :archivo2
      t.string :url1
      t.string :url2
      t.text :data1
      t.text :data2
      t.string :codigo
      t.string :email
      t.string :idioma
      t.timestamps
    end
    add_index :comparaciones, :idioma_id
  end

  def self.down
    drop_table :comparaciones
  end
end
