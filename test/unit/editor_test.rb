require 'test_helper'

class EditorTest < Test::Unit::TestCase
  should_have_many :users
  should_validate_presence_of :name
end
