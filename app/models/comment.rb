class Comment < ActiveRecord::Base
  include Pacecar
  belongs_to :task
  belongs_to :user
  has_many :votes, :as => :voteable, :dependent => :destroy
  validates_presence_of :description
  named_scope :order_by_correct, :order => 'correct'
end
