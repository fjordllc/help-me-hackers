class TasksController < ApplicationController
  before_filter :find_task
  before_filter :login_required, :only => [:new, :create, :edit, :update, :destroy, :tweet]
  PROBLEMS_PER_PAGE = 20
  HACKS_PER_PAGE = 20

  def index
    options = {:page => params[:page],
               :per_page => PROBLEMS_PER_PAGE,
               :order => 'id DESC'}

    if params[:category]
      @category = Category.find_by_name(params[:category])
      options[:conditions] = ['category_id = ?', @category.id]
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
    @task = Task.new(:bounty => 0, :category_id => 8, :license_id => 5)
  end

  def edit
  end

  def create
    @task = Task.new(params[:task])
    @task.user = current_user

    if @task.save
      flash[:notice] = t('Task was successfully created')
      redirect_to @task
    else
      render :action => :new
    end
  end

  def update
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
