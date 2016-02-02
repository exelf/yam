require "bundler/capistrano"

server "212.71.252.148", :web, :app, :db, primary: true

set :application, "yam"
set :user, "emilian"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm, "git"
set :repository, "git@github.com:sapanayaka/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true

ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup"

namespace :deploy do

  task :start do
    run "cd #{current_path} && bundle exec puma -C config/puma.rb"
  end
  task :stop do
    run "cd #{current_path} && bundle exec pumactl -P #{shared_path}/pids/puma.pid stop"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle exec pumactl -S #{shared_path}/pids/puma.state restart"
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /usr/local/nginx/sites-enabled/#{application}"
    run "mkdir -p #{shared_path}/config"
    run "touch #{shared_path}/config/.rbenv-vars"
    run "touch #{shared_path}/config/database.yml"
    puts "Now edit the files in #{shared_path}/config."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/.rbenv-vars #{release_path}/.rbenv-vars"
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end

  before "deploy", "deploy:check_revision"

end
