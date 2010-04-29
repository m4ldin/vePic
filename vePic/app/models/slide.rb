class Slide < ActiveRecord::Base
  belongs_to :slideshow
  has_many :images
  has_many :highlights
end
