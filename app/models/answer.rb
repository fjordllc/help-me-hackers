class Answer < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user

  validates_presence_of :description
end
