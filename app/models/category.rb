class Category < ActiveRecord::Base
  has_and_belongs_to_many :businesses

  validates_presence_of :name

  scope :by_name, order(:name)
  scope :valid, where('id not in (359, 383, 444)')

  def to_param
    name
  end

end