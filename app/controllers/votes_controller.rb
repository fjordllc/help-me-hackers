class VotesController < ApplicationController
  before_filter :login_required, :only => [:create]

  def create
    redirect_to '/404.html', :status => 404 unless request.xhr?
    vote = Vote.new(params[:vote])
    vote.user = current_user
    vote.voted_user_id = vote.voteable.id

    if vote.save
      res = tweet(vote.comment)
      logger.info "res: #{res.to_s}"
      count = Vote.count(:conditions => [
        'voteable_id = ? and voteable_type = ?',
        vote.voteable_id, vote.voteable_type])
      logger.info("save vote: succeed")
      render :json => { :count => count }
    else
      logger.info("save vote: error")
      render :json => { :error => vote.errors, :status => :unprocessable_entity }
    end
  end

  private
  def tweet(message)
    logger.info("tweet: #{message}")
    current_user.twitter.post('/statuses/update.json', 'status' => message)
  end
end
