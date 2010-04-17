class TopController < ApplicationController
  PROBLEMS_PER_PAGE = 20

  def index
    @problems = Problem.paginate(
      :page => params[:page],
      :per_page => PROBLEMS_PER_PAGE,
      :order => 'id DESC')
  end
end
