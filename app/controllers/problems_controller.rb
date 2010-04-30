class ProblemsController < ApplicationController
  before_filter :find_problem
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

    if params[:tag]
      @tag = Tag.find_by_name(params[:tag])
      options[:joins] = [:taggings]
      options[:conditions] = ['taggable_type = ? AND tag_id = ?', 'Problem', @tag.id]
    end

    @problems = Problem.paginate(options)
  end

  def wanted
    @problems = Problem.paginate(
      :page => params[:page],
      :per_page => PROBLEMS_PER_PAGE,
      :conditions => ['bounty > ?', 0],
      :order => 'bounty DESC')
  end

  def unsolved
    @problems = Problem.paginate(
      :page => params[:page],
      :per_page => PROBLEMS_PER_PAGE,
      :conditions => ['hacks.correct = ?', false],
      :joins => [:hacks],
      :order => 'id DESC')
  end

  def show
    @hacks = @problem.hacks.by_correct(:desc).paginate(:page => params[:page], :per_page => HACKS_PER_PAGE)
    @hack = Hack.new(:problem_id => @problem.id)
    Problem.increment_view_by_id(@problem.id)
  end

  def new
    @problem = Problem.new(:bounty => 0)
  end

  def edit
  end

  def create
    @problem = Problem.new(params[:problem])
    @problem.user = current_user

    if @problem.save
      flash[:notice] = t('Problem was successfully created.')
      redirect_to @problem
    else
      render :action => :new
    end
  end

  def update
    if @problem.update_attributes(params[:problem])
      flash[:notice] = t('Problem was successfully updated.')
      redirect_to @problem
    else
      render :action => :edit
    end
  end

  def destroy
    if @problem.destroy
      flash[:notice] = t('Problem was successfully deleted.')
      redirect_to problems_path
    else
      flash[:notice] = t('Problem was not deleted.')
      redirect_to @problem
    end
  end

  private
  def find_problem
    @problem = Problem.find(params[:id]) if params[:id]
  end
end
