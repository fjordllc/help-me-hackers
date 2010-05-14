class TasksController < ApplicationController
  before_filter :find_task
  before_filter :login_required, :only => [:new, :create, :edit, :update, :destroy, :tweet]
  PROBLEMS_PER_PAGE = 20
  HACKS_PER_PAGE = 20

  def index
    options = {:page => params[:page],
               :per_page => PROBLEMS_PER_PAGE,
               :order => 'id DESC'}

    if params[:project]
      @project = Project.find(params[:project])
      options[:conditions] = ['project_id = ?', @project.id]
    end

    if params[:language]
      @language = Language.find_by_name(params[:language])
      options[:conditions] = ['language_id = ?', @language.id]
    end

    if params[:tag]
      @tag = Tag.find_by_name(params[:tag])
      options[:joins] = [:taggings]
      options[:conditions] = ['taggable_type = ? AND tag_id = ?', 'Task', @tag.id]
    end

    @tasks = Task.paginate(options)
  end

  def wanted
    @tasks = Task.unsolved.paid.paginate(
      :page     => params[:page],
      :per_page => PROBLEMS_PER_PAGE)
  end

  def unsolved
    @tasks = Task.unsolved.paginate(
      :page     => params[:page],
      :per_page => PROBLEMS_PER_PAGE)
  end

  def show
    @comments = @task.comments.by_correct(:desc).paginate(
      :page => params[:page],
      :per_page => HACKS_PER_PAGE)
    @comment = Comment.new(:task_id => @task.id)
    Task.increment_view_by_id(@task.id)
  end

  def new
    options = if logged_in? and current_user.language.present?
                {:license_id  => 5,
                 :language_id => current_user.language.id}
              else
                {:license_id => 5}
              end
    @task = Task.new(options)
  end

  def edit
  end

  def create
    @task = Task.new(params[:task])
    @task.bounty = 0 if @task.bounty.nil?
    @task.user = current_user

    if @task.save
      flash[:notice] = t('Task was successfully created')
      redirect_to @task
    else
      render :action => :new
    end
  end

  def update
    params[:task][:bounty] = 0 unless params[:task][:bounty]
    if @task.update_attributes(params[:task])
      flash[:notice] = t('Task was successfully updated')
      redirect_to @task
    else
      render :action => :edit
    end
  end

  def destroy
    if @task.destroy
      flash[:notice] = t('Task was successfully deleted')
      redirect_to tasks_path
    else
      flash[:notice] = t('Task was not deleted')
      redirect_to @task
    end
  end

  private
  def find_task
    @task = Task.find(params[:id]) if params[:id]
  end
end
