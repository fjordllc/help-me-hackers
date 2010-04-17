set :deploy_to, "/var/www/#{application}"
role :app, "help-me-hackers.com"
role :web, "help-me-hackers.com"
role :db,  "help-me-hackers.com", :primary => true
