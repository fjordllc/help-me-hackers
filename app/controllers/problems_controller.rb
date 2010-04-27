class ProblemsController < ApplicationController
  before_filter :find_problem
  before_filter :login_required, :only => [:new, :create, :edit, :update, :destroy, :tweet]
  PROBLEMS_PER_PAGE = 20
  ANSWERS_PER_PAGE = 20

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

  # POST
  def tweet
    comment = params[:problem][:comment] ? ' ' + params[:problem][:comment] : ''
    current_user.tweet("@#{@problem.user.login}#{comment}", problem_url(@problem))
    flash[:notice] = 'ReTweetしました。'
    redirect_to @problem
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
      :conditions => ['answers.correct = ?', false],
      :joins => [:answers],
      :order => 'id DESC')
  end

  def show
    @answers = Answer.paginate(:conditions => ['problem_id = ?', @problem.id],
                               :page => params[:page],
                               :order => 'correct desc',
                               :per_page => ANSWERS_PER_PAGE)
    @answer = Answer.new(:problem_id => @problem.id)
    @comment = @problem.comments.new
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
      flash[:notice] = '問題を作成しました。'
      redirect_to @problem
    else
      render :action => :new
    end
  end

  def update
    if @problem.update_attributes(params[:problem])
      flash[:notice] = '問題を編集しました。'
      redirect_to @problem
    else
      render :action => :edit
    end
  end

  def destroy
    if @problem.destroy
      flash[:notice] = '問題を削除しました。'
      redirect_to problems_path
    else
      flash[:error] = '問題を削除できませんでした。'
      redirect_to @problem
    end
  end

  private
  def find_problem
    @problem = Problem.find(params[:id]) if params[:id]
  end
end
