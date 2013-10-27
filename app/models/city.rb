class City < ActiveRecord::Base
  has_many :businesses

  validates_presence_of :name
end