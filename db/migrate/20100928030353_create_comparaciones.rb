class CreateComparaciones < ActiveRecord::Migration
  def self.up
    create_table :comparaciones do |t|
      t.string :filename1
      t.string :filename2
      t.string :url1
      t.string :url2
      t.text :data1
      t.text :data2
      t.string :code
      t.string :email
      t.string :language_id
      t.timestamps
    end
  end

  def self.down
    drop_table :comparaciones
  end
end
