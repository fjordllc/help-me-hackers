require 'spec_helper'

describe Language do
  fixtures :languages

  should_have_many :users
  should_have_many :problems
  should_validate_presence_of :name
end
