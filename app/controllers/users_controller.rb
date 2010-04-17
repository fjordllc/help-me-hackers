class UsersController < ApplicationController
  before_filter :find_user
  USERS_PER_PAGE = 20

  def index
    @users = User.paginate(:page => params[:page], :per_page => USERS_PER_PAGE)
  end

  def show
    @user = User.find_by_login(params[:login])
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
