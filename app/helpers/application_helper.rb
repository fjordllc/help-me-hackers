module ApplicationHelper
  def select_by_model(object, method)
    select object.class.name.downcase, method, build_model_list(method),
      :selected => object.send(method.to_s)
  end

  def select_project(object, method)
    select object.class.name.downcase,
      method,
      ([['', '']] + build_raw_model_list(method)),
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

  def twitter_url(name)
    "http://twitter.com/#{h(name)}"
  end

  def github_url(name)
    "http://github.com/#{h(name)}"
  end

  def bitbucket_url(name)
    "http://bitbucket.org/#{h(name)}"
  end

  def bitlize(url)
    conf = YAML.load_file File.join(RAILS_ROOT, "config", "twitter_auth.yml")
    bitly = Bitly.new(conf[RAILS_ENV]['bitly_api_username'], conf[RAILS_ENV]['bitly_api_key'])
    bitly.shorten(url).short_url
  end

  def users_title
    if params[:language]
      t("label.language.#{@language.name}") + ' - Users'
    elsif params[:state]
      t("label.state.#{@state.name}") + ' - Users'
    else
      'Users'
    end
  end

  def tasks_title
    if params[:project]
      "タスク - #{h(@project.name)}"
    elsif params[:language]
      "タスク - #{t("label.language.#{params[:language]}")}"
    elsif params[:tag]
      "タスク - #{params[:tag]}"
    else
      'タスク'
    end
  end

  def tasks_class
    if params[:tag]
      'content tag'
    else
      'content'
    end
  end

  def good_task_retweet(task)
    good_retweet(task.user.login, task.title, task_url(task))
  end

  def good_comment_retweet(comment)
    good_retweet(comment.user.login, comment.description, "#{task_url(comment.task)}#comment-#{comment.id}")
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

  def task_attrs(task)
    value = "task content"
    value += ' solved' if task.solved?
    value += ' free' if task.bounty.zero?
    {:class => value}
  end

  def comment_attrs(comment)
    option = {:id => "comment-#{comment.id}"}
    if comment.correct
      option.merge!({:class => 'comment correct'})
    else
      option.merge!({:class => 'comment'})
    end
    option
  end

  def strip_tags(str)
    ActionView::Base.full_sanitizer.sanitize(str)
  end

  def version
    open("#{RAILS_ROOT}/VERSION") {|f| f.read }
  rescue
    '20100501000000'
  end

  def good_retweet(name, title, url, hashtag = Application::HASH_TAG)
    "Good! RT @#{name} #{pritty_truncate(title, :length => 60)} #{bitlize(task_url(@task))} #{hashtag}"
  end

  def tweet(message)
    current_user.twitter.post('/statuses/update.json', 'status' => message)
  end

  def good_retweet(name, title, url, hashtag = Application::HASH_TAG)
    "Good! RT @#{name} #{pretty_truncate(title, :length => 60)} #{bitlize(task_url(@task))} #{hashtag}"
  end

  def pretty_truncate(str, options)
    options[:length] = 60 unless options[:length]
    truncate(str.gsub(/\s+/m, ' '), options)
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

  def build_raw_model_list(method)
    str = method.to_s.humanize
    list = str.
           constantize.
           all.
           collect {|e| [e.name, e.id] }
    list.sort {|a, b| a[1] <=> b[1] }
  end
end
