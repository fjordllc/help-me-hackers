require 'test_helper'

class StateTest < Test::Unit::TestCase
  should_belong_to :country
  should_validate_presence_of :name
end
