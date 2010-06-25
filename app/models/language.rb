class Language < ActiveRecord::Base
  has_many :users
  has_many :tasks
  validates_presence_of :name
end
