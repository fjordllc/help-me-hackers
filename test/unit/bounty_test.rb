require 'test_helper'

class BountyTest < Test::Unit::TestCase
  should_belong_to :task
  should_belong_to :user
  should_validate_presence_of :task
  should_validate_presence_of :user
  should_validate_presence_of :amount
  should_validate_numericality_of :amount,
                                  :only_ionteger => true,
                                  :greater_than => 100
end
