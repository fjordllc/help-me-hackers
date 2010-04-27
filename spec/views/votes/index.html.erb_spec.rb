require 'spec_helper'

describe "/votes/index.html.erb" do
  include VotesHelper

  before(:each) do
    assigns[:votes] = [
      stub_model(Vote,
        :vote => false,
        :voteable_id => 1,
        :voteable_type => "value for voteable_type",
        :user => 1
      ),
      stub_model(Vote,
        :vote => false,
        :voteable_id => 1,
        :voteable_type => "value for voteable_type",
        :user => 1
      )
    ]
  end

  it "renders a list of votes" do
    render
    response.should have_tag("tr>td", false.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for voteable_type".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
