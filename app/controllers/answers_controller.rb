class AnswersController < ApplicationController
  before_filter :find_answer
  before_filter :login_required, :only => [:create, :edit, :update, :destroy]

  def edit
  end

  def create
    @answer = Answer.new(params[:answer])
    @answer.user = current_user
    if @answer.save
      flash[:notice] = '回答を作成しました。'
      redirect_to problem_path(@answer.problem)
    else
      render :action => :new
    end
  end

  def update
    if @answer.update_attributes(params[:answer])
      flash[:notice] = '回答を編集しました。'
      redirect_to problem_path(@answer.problem)
    else
      render :action => :edit
    end
  end

  def destroy
    problem = @answer.problem
    if @answer.destroy
      flash[:notice] = '回答を削除しました。'
      redirect_to problem_path(problem)
    else
      flash[:error] = '回答を削除できませんでした。'
      redirect_to problem_path(problem)
    end
  end

  private
  def find_answer
    @answer = Answer.find(params[:id]) if params[:id]
  end
end
