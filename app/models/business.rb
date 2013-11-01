#encoding: utf-8

class Business < ActiveRecord::Base
  belongs_to :city

  has_many :phones_addresses, :dependent => :destroy
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :keywords

  validates_presence_of :name

  scope :random, order("rand()")

  def to_param
    "#{id}-#{name}".mb_chars.downcase.gsub(/[^a-z0-9а-яії]+/i, '-')
  end

  def title
    name
  end

  def description
    name
  end

  def format_schedule
    self.schedule.gsub("<table", '<table data-role="table" class="ui-shadow table-stripe ui-responsive"').sub("<tr", '<tr class="ui-bar-d"')
  end

end