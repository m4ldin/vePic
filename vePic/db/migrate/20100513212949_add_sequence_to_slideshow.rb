class AddSequenceToSlideshow < ActiveRecord::Migration
  def self.up
    add_column :slideshows, :sequence, :string
  end

  def self.down
    remove_column :slideshows, :sequence
  end
end
