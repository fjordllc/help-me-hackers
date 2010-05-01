require 'capistrano/ext/multistage'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :application, 'help-me-hackers'
set :scm, :git
set :repository,  "git://github.com/komagata/help-me-hackers.git"
set :use_sudo, false
set :user, 'deployer'

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "make symlink to config file"
  task :symlink_config, :roles => :app, :except => {:no_release => true} do
    run "ln -s #{deploy_to}/shared/database.yml #{current_path}/config/database.yml"
    run "ln -s #{deploy_to}/shared/twitter_auth.yml #{current_path}/config/twitter_auth.yml"
  end
  after 'deploy:symlink', 'deploy:symlink_config'
end

after :deploy, 'deploy:cleanup'


Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
