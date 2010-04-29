class CreateHighlights < ActiveRecord::Migration
  def self.up
    create_table :highlights do |t|
      t.text :body
      t.integer :x
      t.integer :y
      t.integer :h
      t.integer :w
      t.integer :slide_id

      t.timestamps
    end
  end

  def self.down
    drop_table :highlights
  end
end
