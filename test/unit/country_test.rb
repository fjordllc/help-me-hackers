require 'test_helper'

class CountryTest < Test::Unit::TestCase
  should_have_many :states
  should_validate_presence_of :name
end
