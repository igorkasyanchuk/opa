class Keyword < ActiveRecord::Base
  has_and_belongs_to_many :businesses

  validates_presence_of :name

  scope :by_name, order(:name)

  def to_param
    name
  end
end