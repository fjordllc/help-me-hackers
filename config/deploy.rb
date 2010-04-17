require 'capistrano/ext/multistage'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :application, 'help-me-hackers'
set :scm, :git
set :repository,  "git@github.com:komagata/help-me-hackers.git"
set :use_sudo, false
set :user, 'deployer'

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, 'deploy:cleanup'
