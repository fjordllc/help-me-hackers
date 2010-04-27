require 'spec_helper'

describe VotesController do

  def mock_vote(stubs={})
    @mock_vote ||= mock_model(Vote, stubs)
  end

  describe "GET index" do
    it "assigns all votes as @votes" do
      Vote.stub(:find).with(:all).and_return([mock_vote])
      get :index
      assigns[:votes].should == [mock_vote]
    end
  end

  describe "GET show" do
    it "assigns the requested vote as @vote" do
      Vote.stub(:find).with("37").and_return(mock_vote)
      get :show, :id => "37"
      assigns[:vote].should equal(mock_vote)
    end
  end

  describe "GET new" do
    it "assigns a new vote as @vote" do
      Vote.stub(:new).and_return(mock_vote)
      get :new
      assigns[:vote].should equal(mock_vote)
    end
  end

  describe "GET edit" do
    it "assigns the requested vote as @vote" do
      Vote.stub(:find).with("37").and_return(mock_vote)
      get :edit, :id => "37"
      assigns[:vote].should equal(mock_vote)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created vote as @vote" do
        Vote.stub(:new).with({'these' => 'params'}).and_return(mock_vote(:save => true))
        post :create, :vote => {:these => 'params'}
        assigns[:vote].should equal(mock_vote)
      end

      it "redirects to the created vote" do
        Vote.stub(:new).and_return(mock_vote(:save => true))
        post :create, :vote => {}
        response.should redirect_to(vote_url(mock_vote))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved vote as @vote" do
        Vote.stub(:new).with({'these' => 'params'}).and_return(mock_vote(:save => false))
        post :create, :vote => {:these => 'params'}
        assigns[:vote].should equal(mock_vote)
      end

      it "re-renders the 'new' template" do
        Vote.stub(:new).and_return(mock_vote(:save => false))
        post :create, :vote => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested vote" do
        Vote.should_receive(:find).with("37").and_return(mock_vote)
        mock_vote.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :vote => {:these => 'params'}
      end

      it "assigns the requested vote as @vote" do
        Vote.stub(:find).and_return(mock_vote(:update_attributes => true))
        put :update, :id => "1"
        assigns[:vote].should equal(mock_vote)
      end

      it "redirects to the vote" do
        Vote.stub(:find).and_return(mock_vote(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(vote_url(mock_vote))
      end
    end

    describe "with invalid params" do
      it "updates the requested vote" do
        Vote.should_receive(:find).with("37").and_return(mock_vote)
        mock_vote.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :vote => {:these => 'params'}
      end

      it "assigns the vote as @vote" do
        Vote.stub(:find).and_return(mock_vote(:update_attributes => false))
        put :update, :id => "1"
        assigns[:vote].should equal(mock_vote)
      end

      it "re-renders the 'edit' template" do
        Vote.stub(:find).and_return(mock_vote(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested vote" do
      Vote.should_receive(:find).with("37").and_return(mock_vote)
      mock_vote.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the votes list" do
      Vote.stub(:find).and_return(mock_vote(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(votes_url)
    end
  end

end
