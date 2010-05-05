class HacksController < ApplicationController
  before_filter :find_hack
  before_filter :login_required, :only => [:create, :edit, :update, :destroy]

  def edit
  end

  def create
    @hack = Hack.new(params[:hack])
    @hack.user = current_user
    if @hack.save
      flash[:notice] = t('Hack was successfully created')
      redirect_to problem_path(@hack.problem)
    else
      render :action => :new
    end
  end

  def update
    if @hack.update_attributes(params[:hack])
      flash[:notice] = t('Hack was successfully updated')
      redirect_to problem_path(@hack.problem)
    else
      render :action => :edit
    end
  end

  def destroy
    problem = @hack.problem
    if @hack.destroy
      flash[:notice] = t('Hack was successfully deleted')
      redirect_to problem_path(problem)
    else
      flash[:notice] = t('Hack was not deleted')
      redirect_to problem_path(problem)
    end
  end

  private
  def find_hack
    @hack = Hack.find(params[:id]) if params[:id]
  end
end
