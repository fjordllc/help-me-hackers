set :deploy_to, "/var/www/dev/#{application}"
role :app, "help-me-hackers.dev.fjord.jp"
role :web, "help-me-hackers.dev.fjord.jp"
role :db,  "help-me-hackers.dev.fjord.jp", :primary => true
