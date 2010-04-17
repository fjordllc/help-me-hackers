class Language < ActiveRecord::Base
  has_many :users
  has_many :problems

  validates_presence_of :name

  def self.for_programming
    self.find(:all, :conditions => ['id < ?', 1000])
  end

  def self.for_natural
    self.find(:all, :conditions => ['id >= ?', 1000])
  end
end
