class Editor < ActiveRecord::Base
  has_many :users
  validates_presence_of :name
  validates_uniqueness_of :name
end
