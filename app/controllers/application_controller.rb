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
    current_user.twitter.post('/statuses/update.json', 'status' => message)
  end
end

unless ActionView::Helpers::InstanceTag.instance_methods.include?('to_label_tag_without_i18n')
  ActionView::Helpers::InstanceTag.class_eval do
    def to_label_tag_with_i18n(text = nil, options = {})
      options = options.stringify_keys
      tag_value = options.delete("value")
      name_and_id = options.dup
      name_and_id["id"] = name_and_id["for"]
      add_default_name_and_id_for_value(tag_value, name_and_id)
      options.delete("index")
      options["for"] ||= name_and_id["id"]
      if text.blank?
        content = object.class.respond_to?(:human_attribute_name) ? object.class.human_attribute_name(method_name) : method_name.humanize
      else
        content = text.to_s
      end
      #content = (text.blank? ? nil : text.to_s) || object_name.classify.constantize.human_attribute_name(method_name)
      label_tag(name_and_id["id"], content, options)
    end
    alias_method_chain :to_label_tag, :i18n
  end
end
