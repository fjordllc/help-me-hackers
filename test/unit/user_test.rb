require 'test_helper'

class UserTest < Test::Unit::TestCase
  should_belong_to :language
  should_belong_to :state
  should_have_many :tasks
  should_have_many :comments
end
