require 'test_helper'

class TaskTest < Test::Unit::TestCase
  should_belong_to :user
  should_belong_to :language
  should_belong_to :license
  should_belong_to :project
  should_have_many :comments
  should_validate_presence_of :title
  should_validate_presence_of :description
  should_validate_presence_of :language
  should_validate_presence_of :license
  should_validate_presence_of :user
  should_validate_presence_of :bounty
  should_ensure_length_in_range :title, (4..255)
  should_ensure_length_at_least :description, 20
end
