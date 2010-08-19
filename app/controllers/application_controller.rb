# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
#  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  private
  def reply(name, title, url, hashtag = Application::HASH_TAG)
    logger.info "url: #{url}"
    title = ApplicationController.helpers.pretty_truncate(title, :length => 60)
    url   = ApplicationController.helpers.bitlize(url)
    tweet("@#{name} #{title} #{url} #{hashtag}")
  end

  def help!(title, url, hashtag = Application::HASH_TAG)
    title = ApplicationController.helpers.pretty_truncate(title, :length => 60)
    url   = ApplicationController.helpers.bitlize(url)
    tweet("HELP!: #{title} #{url} #{hashtag}")
  end

  def tweet(message)
    if Rails.env.production?
      current_user.twitter.post('/statuses/update.json', 'status' => message)
    else
      logger.info "tweet: #{message}"
    end
  end
end
