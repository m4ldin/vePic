class Slide < ActiveRecord::Base
  belongs_to :slideshow
  has_one :image
  has_many :highlights
end
