class Answer < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user

  validates_presence_of :description
  validates_length_of :description, :minimum => 30

  named_scope :corrected, :conditions => {:correct => true}
  named_scope :order_by_correct, :order => 'correct'
end
