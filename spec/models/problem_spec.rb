require 'spec_helper'

describe Problem do
  fixtures :problems

  should_belong_to :user
  should_belong_to :language
  should_belong_to :license
  should_belong_to :kind
  should_have_many :answers
  should_validate_presence_of :title
  should_validate_presence_of :description
  should_validate_presence_of :kind
  should_validate_presence_of :language
  should_validate_presence_of :license
  should_validate_presence_of :user
  should_validate_presence_of :bounty
end
