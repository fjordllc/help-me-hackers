class BountiesController < ApplicationController
  before_filter :login_required => [:create, :update, :destroy]
  before_filter :find_bounty, :only => [:show]
  layout false

  def index
    model = Bounty
    model = model.scoped_by_task_id(params[:task_id]) if params[:task_id]
    @bounties = model.all
  end

  def show
  end

  def create
    @bounty = Bounty.new(params[:bounty])
    @bounty.user = current_user
    if @bounty.save
      render :json => @bounty, :status => :created, :location => @bounty
    else
      render :json => @bounty.errors, :status => :unprocessable_entity
    end
  end

  def update
    @bounty = Bounty.find_by_id_and_user_id(params[:id], current_user.id)
    if @bounty.update_attributes(params[:bounty])
      head :ok
    else
      render :json => @bounty.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @bounty = Bounty.find_by_id_and_user_id(params[:id], current_user.id)
    if @bounty.destroy
      head :ok
    else
      render :json => @bounty.errors, :status => :unprocessable_entity
    end
  end

  def total_amount
    total_bounty = Task.find(params[:task_id]).total_bounty
    render :template => 'bounties/_total_amount', :locals => {:total_amount => total_bounty}
  end

  private
  def find_bounty
    @bounty = Bounty.find(params[:id]) if params[:id]
  end
end
