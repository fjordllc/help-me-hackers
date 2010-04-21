require 'spec_helper'

describe License do
  fixtures :licenses

  should_have_many :problems
  should_validate_presence_of :name
end
