require 'spec_helper'

describe State do
  fixtures :states

  should_belong_to :country
  should_validate_presence_of :name
end
