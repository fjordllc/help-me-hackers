require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  should_have_many :tasks
  should_validate_presence_of :name
end
