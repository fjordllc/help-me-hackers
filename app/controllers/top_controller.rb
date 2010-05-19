class TopController < ApplicationController
  TASKS_PER_PAGE = 20

  def index
    @tasks = Task.paginate(
      :page     => params[:page],
      :per_page => TASKS_PER_PAGE,
      :order    => 'updated_at DESC')
  end
end
