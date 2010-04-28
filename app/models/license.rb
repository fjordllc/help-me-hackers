class License < ActiveRecord::Base
  has_many :problems
  validates_presence_of :name
end
