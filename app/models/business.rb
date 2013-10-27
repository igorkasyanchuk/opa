class Business < ActiveRecord::Base
  belongs_to :city

  has_many :phones_addresses, :dependent => :destroy
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :keywords

  validates_presence_of :name

  scope :random, order("rand()")

  def to_param
    "#{id}-#{name}".downcase
  end

  def title
    name
  end

  def description
    name
  end

end