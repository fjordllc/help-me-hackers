require 'spec_helper'

describe User do
  fixtures :users

  should_belong_to :language
  should_belong_to :state
  should_have_many :problems
  should_have_many :answers
end
