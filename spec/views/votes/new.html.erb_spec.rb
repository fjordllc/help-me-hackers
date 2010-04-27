require 'spec_helper'

describe "/votes/new.html.erb" do
  include VotesHelper

  before(:each) do
    assigns[:vote] = stub_model(Vote,
      :new_record? => true,
      :vote => false,
      :voteable_id => 1,
      :voteable_type => "value for voteable_type",
      :user => 1
    )
  end

  it "renders new vote form" do
    render

    response.should have_tag("form[action=?][method=post]", votes_path) do
      with_tag("input#vote_vote[name=?]", "vote[vote]")
      with_tag("input#vote_voteable_id[name=?]", "vote[voteable_id]")
      with_tag("input#vote_voteable_type[name=?]", "vote[voteable_type]")
      with_tag("input#vote_user[name=?]", "vote[user]")
    end
  end
end
