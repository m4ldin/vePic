class Topic < ActiveRecord::Base
  validates_presence_of :title, :body
  has_many :posts
end
