class UsersController < ApplicationController
  before_filter :find_user
  USERS_PER_PAGE = 20

  def index
    model = User

    if params[:language]
      @language = Language.find_by_name(params[:language])
      model = model.scoped_by_language_id(@language.id)
    end

    if params[:editor]
      @editor = Editor.find_by_name(params[:editor])
      model = model.scoped_by_editor_id(@editor.id)
    end

    if params[:state]
      @state = State.find_by_name(params[:state])
      model = model.scoped_by_state_id(@state.id)
    end

    @users = model.paginate(:page     => params[:page],
                            :per_page => USERS_PER_PAGE,
                            :order    => 'id DESC')
  end

  def show
    @user = User.find_by_login(params[:login])
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 if @user.nil?
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
