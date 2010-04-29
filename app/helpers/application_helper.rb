module ApplicationHelper
  def select_by_model(object, method)
    select object.class.name.downcase, method, build_model_list(method),
      :selected => object.send(method.to_s)
  end

  def select_programming_language(object, method)
    list = build_model_list(method).delete_if do |e|
      e[1].to_i >= 1000
    end
    select object.class.name.downcase, method, list,
      :selected => object.send(method.to_s)
  end

  def link_to_unless_current_with_span(name, options = {}, html_options = {})
    if current_page?(options)
      "<span class=\"current\">#{name}</span>"
    else
      link_to name, options, html_options
    end
  end

  def user_path(user)
    "#{root_path}#{user.login}"
  end

  def github_url(name)
    "http://github.com/#{h(name)}"
  end

  def twitter_url(name)
    "http://twitter.com/#{h(name)}"
  end

  def bitlize(url)
    conf = YAML.load_file File.join(RAILS_ROOT, "config", "twitter_auth.yml")
    bitly = Bitly.new(conf[RAILS_ENV]['bitly_api_username'], conf[RAILS_ENV]['bitly_api_key'])
    bitly.shorten(url).short_url
  end

  def users_title
    if params[:language]
      "#{t("label.language.#{@language.name}")} #{t('activerecord.models.user')}"
    else
      t('activerecord.models.user')
    end
  end

  def problems_title
    if params[:category]
      "#{t('activerecord.models.problem')} - #{t("label.category.#{@category.name}")}"
    elsif params[:tag]
      "#{t('activerecord.models.problem')} - #{@tag.name}"
    else
      t('activerecord.models.problem')
    end
  end

  def problems_class
    if params[:category]
      "content #{@category.name}"
    elsif params[:tag]
      'content tag'
    else
      'content'
    end
  end

  def good_problem_retweet(problem)
    good_retweet(problem.user.login, truncate(problem.title, 60), problem_url(problem))
  end

  def good_answer_retweet(answer)
    good_retweet(answer.user.login, answer.description, "#{problem_url(answer.problem)}#answer-#{answer.id}")
  end

  def tweeted?(object)
    return false unless logged_in?
    object.votes.scoped_by_user_id(current_user.id).present?
  end

  def good_attrs(object)
    id_name = object.class.name.downcase
    if tweeted?(object)
      {:class => 'good tweeted'}
    else
      {:class => 'good', :onclick => "$('##{id_name}_#{object.id}_vote_form').toggle()"}
    end
  end

  def problem_attrs(problem)
    value = "problem content #{problem.category.name}"
    value += ' solved' if problem.solved?
    value += ' free' if problem.bounty.zero?
    {:class => value}
  end

  def answer_attrs(answer)
    option = {:id => "answer-#{answer.id}"}
    if answer.correct
      option.merge!({:class => 'answer correct'})
    else
      option.merge!({:class => 'answer'})
    end
    option
  end

  private
  def build_model_list(method)
    default = [[t('label.please-select'), '']]
    str = method.to_s.humanize
    list = str.
           constantize.
           all.
           collect {|e| [t("label.#{str.downcase}.#{e.name}"), e.id] }
    default + list.sort {|a, b| a[1] <=> b[1] }
  end

  def good_retweet(name, title, url, hashtag = '#helpmehackers')
    "Good! RT @#{name} #{truncate(title, 60)} #{bitlize(problem_url(@problem))} #{hashtag}"
  end
end
