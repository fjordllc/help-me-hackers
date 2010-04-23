class User < TwitterAuth::GenericUser
  belongs_to :language
  belongs_to :state
  has_many :problems
  has_many :answers

  def prize
    p = ActiveRecord::Base.connection.select_values(
      "select sum(problems.bounty) as prize
       from answers 
         join users on answers.user_id = users.id 
         join problems on answers.problem_id = problems.id 
       where answers.correct = true and users.id = #{self.id} 
       group by problems.id limit 1", :prize
    )
    p.empty? ? 0 : p.first.to_i
  end

  def tweet(message, url, tag = '#helpmehackers')
    conf = YAML.load_file File.join(RAILS_ROOT, "config", "twitter_auth.yml")
    bitly = Bitly.new(conf[RAILS_ENV]['bitly_api_username'], conf[RAILS_ENV]['bitly_api_key'])
    message = "#{message} #{bitly.shorten(url).short_url} #{tag}"
    logger.info("tweet: #{message}")
    update_tweet_status(message)
  end

  private
  def update_tweet_status(message)
    self.twitter.post('/statuses/update.json', 'status' => message)
  end
end
