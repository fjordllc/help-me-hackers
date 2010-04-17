class AccountsController < ApplicationController
  before_filter :find_user
  before_filter :login_required

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = 'ユーザーを編集しました。'
      redirect_to account_path
    else
      render :action => :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = 'ユーザーを削除しました。'
      redirect_to users_path
    else
      flash[:error] = 'ユーザーを削除できませんでした。'
      redirect_to @user
    end
  end

  private
  def find_user
    @user = current_user 
  end
end
