class TopController < ApplicationController
  PROBLEMS_PER_PAGE = 20

  def index
    @tasks = Task.paginate(
      :page => params[:page],
      :per_page => PROBLEMS_PER_PAGE,
      :order => 'id DESC')
  end
end
