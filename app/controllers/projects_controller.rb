class ProjectsController < ApplicationController
  before_filter :find_project
  before_filter :login_required, :except => [:index, :show]
  PROJECTS_PER_PAGE = 20

  def index
    @projects = Project.paginate(:page => params[:page], :per_page => PROJECTS_PER_PAGE)
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:notice] = t('Project was successfully created')
      redirect_to @project
    else
      render :action => :new
    end
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = t('Project was successfully updated')
      redirect_to @project
    else
      render :action => :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:notice] = t('Project was successfully deleted')
      redirect_to projects_path
    else
      flash[:error] = t('Project was not deleted')
      redirect_to @project
    end
  end

  private
  def find_project
    @project = Project.find(params[:id]) if params[:id]
  end
end
