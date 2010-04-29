class CreateSlideshows < ActiveRecord::Migration
  def self.up
    create_table :slideshows do |t|
      t.integer :topic_id

      t.timestamps
    end
  end

  def self.down
    drop_table :slideshows
  end
end
