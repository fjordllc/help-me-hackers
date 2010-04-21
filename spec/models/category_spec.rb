require 'spec_helper'

describe Category do
  fixtures :categories

  should_have_many :problems
  should_validate_presence_of :name
end
