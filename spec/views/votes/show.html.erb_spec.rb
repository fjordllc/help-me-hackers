require 'spec_helper'

describe "/votes/show.html.erb" do
  include VotesHelper
  before(:each) do
    assigns[:vote] = @vote = stub_model(Vote,
      :vote => false,
      :voteable_id => 1,
      :voteable_type => "value for voteable_type",
      :user => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/false/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ voteable_type/)
    response.should have_text(/1/)
  end
end
