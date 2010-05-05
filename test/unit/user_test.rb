require 'test_helper'

class UserTest < Test::Unit::TestCase
  should_belong_to :language
  should_belong_to :state
  should_have_many :problems
  should_have_many :hacks
end
