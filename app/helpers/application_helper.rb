module ApplicationHelper
  def select_by_model(object, method)
    select object, method, build_model_list(method), :selected => object.send(method)
  end

  def select_programming_language(object, method)
    list = build_model_list(method).delete_if do |e|
      e[1].to_i >= 1000
    end
    select object, method, list, :selected => object.send(method)
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
end
