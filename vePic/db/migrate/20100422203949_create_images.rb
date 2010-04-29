class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :slide_id
      t.string :path
      t.string :title
      t.string :author

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
