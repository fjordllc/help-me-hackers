class UsersController < ApplicationController
  before_filter :find_user
  USERS_PER_PAGE = 100

  def index
    options = {:page => params[:page],
               :per_page => USERS_PER_PAGE,
               :order => 'id DESC'}

    if params[:language]
      @language = Language.find_by_name(params[:language])
      options[:conditions] = ['language_id = ?', @language.id]
    end

    @users = User.paginate(options)
  end

  def hacker
    options = {:page => params[:page],
               :per_page => USERS_PER_PAGE,
               :order => 'id DESC'}

    if params[:language]
      @language = Language.find_by_name(params[:language])
      options[:conditions] = ['language_id = ?', @language.id]
    end

    @users = User.scoped_by_hacker(true).paginate(options)
    render 'index'
  end

  def hackee
    options = {:page => params[:page],
               :per_page => USERS_PER_PAGE,
               :order => 'id DESC'}

    if params[:language]
      @language = Language.find_by_name(params[:language])
      options[:conditions] = ['language_id = ?', @language.id]
    end

    @users = User.scoped_by_hackee(true).paginate(options)
    render 'index'
  end

  def show
    @user = User.find_by_login(params[:login])
    redirect_to '/404.html', :status => 404 if @user.nil?
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'ユーザーを作成しました。'
      redirect_to root_path
    else
      render :action => :new
    end
  end

  private
  def find_user
    @user = User.find(params[:id]) if params[:id]
  end
end
