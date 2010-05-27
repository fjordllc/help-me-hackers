set :deploy_to, "/var/www/#{application}"
role :app, "help-me-hackers.com"
role :web, "help-me-hackers.com"
role :db,  "help-me-hackers.com", :primary => true

after :deploy, 'deploy:tagging'
#after 'deploy:tagging', 'deploy:notify:tweet'
