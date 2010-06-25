require 'test_helper'

class CommentTest < Test::Unit::TestCase
  should_belong_to :task
  should_belong_to :user
  should_validate_presence_of :description
end
