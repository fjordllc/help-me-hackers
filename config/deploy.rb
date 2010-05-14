require 'capistrano/ext/multistage'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :application, 'help-me-hackers'
set :scm, :git
set :repository,  "git://github.com/komagata/help-me-hackers.git"
set :use_sudo, false
set :user, 'deployer'
set :version, Time.new.strftime('%Y%m%d%H%M%S')

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Create symlink to config file"
  task :symlink_config, :roles => :app, :except => {:no_release => true} do
    run "ln -s #{deploy_to}/shared/database.yml #{release_path}/config/database.yml"
    run "ln -s #{deploy_to}/shared/twitter_auth.yml #{release_path}/config/twitter_auth.yml"
    run "ln -s #{deploy_to}/shared/newrelic.yml #{release_path}/config/newrelic.yml"
  end
  after 'deploy:finalize_update', 'deploy:symlink_config'

  desc "Create release tag"
  task :tagging, :roles => :app, :except => {:no_release => true} do
    run "echo '#{version}' > #{release_path}/VERSION"
    run_locally "echo '#{version}' > VERSION"
    run_locally "git tag v#{version}"
  end

  namespace :notify do
    desc "Tweet release"
    task :tweet do
      require 'rubygems'
      require 'twitter'
      require 'pit'

      config = Pit.get('twitter', :require => {
        'consumer_token_key' => '',
        'consumer_secret'    => '',
        'access_token_key'   => '',
        'access_secret'      => ''
      })

      oauth = Twitter::OAuth.new(config['consumer_token_key'], config['consumer_secret'])
      oauth.authorize_from_access(config['access_token_key'], config['access_secret'])

      client = Twitter::Base.new(oauth)

      msg = "Version #{version}をリリースしました。 http://help-me-hackers.com #hmh"
      client.update(msg)
      puts msg
    end
  end
end

after :deploy, 'deploy:cleanup'


Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
