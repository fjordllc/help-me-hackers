class VotesController < ApplicationController
  before_filter :login_required, :only => [:create]

  def create
    vote = Vote.new(params[:vote])
    vote.user = current_user
    vote.voted_user_id = vote.voteable.id

    if vote.save
      res = ApplicationController.helpers.tweet(vote.comment)
      logger.info "res: #{res.to_s}"
      count = Vote.count(:conditions => [
        'voteable_id = ? and voteable_type = ?',
        vote.voteable_id, vote.voteable_type])
      flash[:notice] = t('Vote was successfully created')
      logger.info("save vote: succeed")
    else
      flash[:notice] = t('Vote was not created')
      logger.info("save vote: error")
    end

    redirect_to :back
  end
end
