require 'spec_helper'

describe VotesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/votes" }.should route_to(:controller => "votes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/votes/new" }.should route_to(:controller => "votes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/votes/1" }.should route_to(:controller => "votes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/votes/1/edit" }.should route_to(:controller => "votes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/votes" }.should route_to(:controller => "votes", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/votes/1" }.should route_to(:controller => "votes", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/votes/1" }.should route_to(:controller => "votes", :action => "destroy", :id => "1") 
    end
  end
end
