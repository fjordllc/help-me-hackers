require 'spec_helper'

describe Country do
  fixtures :countries

  should_have_many :states
  should_validate_presence_of :name
end
