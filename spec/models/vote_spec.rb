require 'spec_helper'

describe Vote do
  before(:each) do
    @valid_attributes = {
      :vote => false,
      :voteable_id => 1,
      :voteable_type => "value for voteable_type",
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Vote.create!(@valid_attributes)
  end
end
