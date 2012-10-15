class Map < ActiveRecord::Base
  attr_accessible :title, :body, :user, :server, :points

  belongs_to :user
  belongs_to :server
  has_many :points
end