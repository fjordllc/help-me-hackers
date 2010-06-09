I18n.load_path += Dir[File.join(RAILS_ROOT, 'lib', 'locale', '*.{rb,yml}')]
I18n.supported_locales = Dir[File.join(RAILS_ROOT, 'lib', 'locale', '*.{rb,yml}')].collect{|v| File.basename(v, ".*")}.uniq
