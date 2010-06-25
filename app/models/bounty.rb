class Bounty < ActiveRecord::Base
  include Pacecar
  belongs_to :user
  belongs_to :task

  validates_presence_of :amount, :task, :user
  validates_numericality_of :amount, :only_ionteger => true, :greater_than_or_equal_to => 100
end
