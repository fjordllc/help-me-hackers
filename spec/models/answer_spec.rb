require 'spec_helper'

describe Answer do
  fixtures :hacks

  should_belong_to :problem
  should_belong_to :user
  should_validate_presence_of :description
end
