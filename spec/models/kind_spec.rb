require 'spec_helper'

describe Kind do
  fixtures :kinds

  should_have_many :problems
  should_validate_presence_of :name
end
