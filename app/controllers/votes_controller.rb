class VotesController < ApplicationController
  before_filter :login_required, :only => [:create]

  def index
    @votes = Vote.all
    render :xml => @votes
  end

  def create
    @vote = Vote.new(params[:vote])
    @vote.user = current_user

    if @vote.save
      @count = Vote.count(:conditions => [
        'voteable_id = ? and voteable_type = ?',
        @vote.voteable_id, @vote.voteable_type])
      render :json => {:success => 1, :count => @count}
    else
      render :json => {:error => @vote.errors, :status => :unprocessable_entity}
    end
  end
end
