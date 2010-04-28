class Language < ActiveRecord::Base
  has_many :users
  has_many :problems
  validates_presence_of :name
end
